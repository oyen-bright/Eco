import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/data/blockchain/blockchain_repository.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/pinata_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/stream_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../wallet_cubit/wallet_cubit.dart';
import 'smart_car_vehicle_model.dart';
import 'vehicle_model.dart';
import 'vehicle_query_options.dart';

part 'vehicle_cubit.freezed.dart';
// part 'vehicle_cubit.g.dart';
part 'vehicle_state.dart';

class VehicleCubit extends Cubit<VehicleState> {
  final LoadingCubit loadingCubit;
  final UserCubit userCubit;
  final LocationService locationService;
  final WalletCubit walletCubit;
  final PinataService pinataService;
  final VehicleService vehicleService;

  VehicleCubit(this.loadingCubit, this.vehicleService, this.userCubit,
      this.locationService, this.walletCubit, this.pinataService)
      : super(const VehicleState.initial()) {
    getAllVehicle();
  }

  Future<({String? error, List<SmartCarVehicle> vehicles})> getSmartCarVehicles(
      {required String token}) async {
    loadingCubit.loading();
    final response = await vehicleService.connectSmartCar(smartCarToken: token);
    loadingCubit.loaded();
    if (response.error != null) {
      return (error: response.error, vehicles: List<SmartCarVehicle>.empty());
    }
    return (error: null, vehicles: response.vehicles ?? []);
  }

  Future<({String? error, String? message})> onTripStartUnlockVehicle(
      {required String rentalId, required String smartCarVehicleId}) async {
    final smartCarVehicleResponse = await vehicleService.getSmartCarVehicleById(
        vehicleID: smartCarVehicleId);
    final onSmartCarVehicleError = smartCarVehicleResponse.error;
    if (onSmartCarVehicleError != null) {
      return (error: onSmartCarVehicleError, message: null);
    }
    final startMilage = smartCarVehicleResponse.vehicle?.odometer;
    if (startMilage == null) {
      return (error: "", message: null);
    }
    final updateRentalResponse =
        await vehicleService.updateRentalBeforeStartTrip(
            rentalID: rentalId, startMillage: startMilage.toString());
    final onUpdateRentalError = updateRentalResponse.error;
    if (onUpdateRentalError != null) {
      return (error: onUpdateRentalError, message: null);
    }
    final unlockVehicleResponse =
        await vehicleService.unlockVehicle(vehicleId: smartCarVehicleId);
    final onUnlockVehicleError = unlockVehicleResponse.error;
    if (onUnlockVehicleError != null) {
      return (error: onUnlockVehicleError, message: null);
    }
    final onUnlockVehicleMessage = unlockVehicleResponse.message;
    return (error: onUnlockVehicleError, message: onUnlockVehicleMessage);
  }

  Future<({String? error, String? message})> onTripStartTrip(
      {required String rentalId, required List<(String, XFile)> images}) async {
    loadingCubit.loading();

    final uploadTripImagesResponse = await _uploadTripImages(images);

    loadingCubit.loaded();
    final onUploadTripImagesError = uploadTripImagesResponse.error;

    if (onUploadTripImagesError != null) {
      if (uploadTripImagesResponse.cid != null &&
          (uploadTripImagesResponse.cid?.isNotEmpty ?? false)) {
        await pinataService.deleteMedia(
            cIDs: uploadTripImagesResponse.cid!.map((e) => e.$2).toList());
      }
      return (error: onUploadTripImagesError, message: null);
    }

    final Map<String, String> mapFromTuples = Map.fromEntries(
        uploadTripImagesResponse.cid!
            .map((tuple) => MapEntry(tuple.$1, tuple.$2)));

    final allKeysAvailable = [
      'backImage',
      'frontImage',
      'insideFront',
      'insideBack',
      "rightImage",
      "leftImage",
    ].map((e) => mapFromTuples.containsKey(e)).every((element) => element);

    if (!allKeysAvailable) {
      return (error: "", message: null);
    }

    final vehicleImages = (
      backImage: mapFromTuples['backImage']!,
      frontImage: mapFromTuples['frontImage']!,
      insideImage:
          "${mapFromTuples['insideFront']!},${mapFromTuples['insideBack']!}",
      leftImage: mapFromTuples['leftImage']!,
      rightImage: mapFromTuples['rightImage']!,
    );

    loadingCubit.loading();

    final updateRentalResponse =
        await vehicleService.updateRentalBeforeStartTrip(
            rentalID: rentalId, beforeTripImage: vehicleImages);

    loadingCubit.loaded();
    final onUpdateRentalError = updateRentalResponse.error;

    if (onUpdateRentalError != null) {
      return (error: onUpdateRentalError, message: null);
    }

    return (error: null, message: null);
  }

  Future<void> getFilterOptions() async {
    final response = await vehicleService.getVehicleFilterValues();
    if (response.error == null) {
      state.maybeMap(
        loading: (_) {
          emit((state as _Loading).copyWith(filterOptions: response.data));
        },
        loaded: (_) {
          emit((state as _Loaded).copyWith(filterOptions: response.data));
        },
        error: (_) {
          emit((state as _Error).copyWith(filterOptions: response.data));
        },
        orElse: () {},
      );
    }
  }

  Future<({String? error, String? rentalID})> rentVehicle(
      {required VehicleRentalModel vehicleData}) async {
    loadingCubit.loading();

    final StreamHandler<VehicleRentingState> statusStream = StreamHandler();
    statusStream.stream.listen((VehicleRentingState event) {
      switch (event) {
        case VehicleRentingState.verifyPayment:
          loadingCubit.loading(message: "Verifying Payment...");
          break;
        case VehicleRentingState.createEscrow:
          loadingCubit.loading(message: "Creating Escrow...");
          break;
        case VehicleRentingState.createRental:
          loadingCubit.loading(message: "Creating Rental...");
          break;
        case VehicleRentingState.makePayment:
          loadingCubit.loading(
            message:
                "To complete your vehicle rental, please make the payment. Open your wallet and confirm the transaction.",
            action1: (
              "Open Wallet",
              () => BlockChainRepository.openConnectedWallet(),
              null
            ),
            action2: ("Cancel rental", () {}, 4294198070),
          );
          break;
        case VehicleRentingState.getApproval:
          loadingCubit.loading(message: "Requesting Approval ...");
          break;
      }
    });

    final response = await vehicleService.rentVehicle(
        userID: userCubit.state.userID,
        vehicleRentalModel: vehicleData,
        statusStream: statusStream);
    loadingCubit.loaded();
    if (response.error != null) {
      return (error: response.error, rentalID: response.rentalID);
    } else {
      return (error: null, rentalID: null);
    }
  }

  void _cancelListVehicle(
      {required List<String> ipfsCIDS, required String? vehicleID}) async {
    await Future.wait([
      vehicleID != null
          ? vehicleService.deleteVehicle(id: vehicleID)
          : Future(() => null),
      pinataService.deleteMedia(cIDs: ipfsCIDS)
    ]);
    return;
  }

  Future<({String? error})> listVehicle({
    required VehicleModel vehicleData,
    List<XFile>? vehicleImages,
    List<XFile>? vehicleVideos,
  }) async {
    List<String> ipfsCIDS = [];
    String? vehicleID;

    final StreamHandler<(VehicleListingState, String?)> statusStream =
        StreamHandler();
    statusStream.stream.listen(((VehicleListingState, String?) event) {
      switch (event.$1) {
        case VehicleListingState.uploadImagesVideos:
          loadingCubit.loading(message: "Processing Images and Videos...");
          break;
        case VehicleListingState.createVehicleData:
          loadingCubit.loading(message: "Creating Vehicle Data...");
          break;
        case VehicleListingState.updateVehicleData:
          loadingCubit.loading(message: "Updating Vehicle Data...");
          break;
        case VehicleListingState.makePayment:
          vehicleID = event.$2;
          loadingCubit.loading(
            message:
                "To complete your vehicle listing, please make the payment. Open your wallet and confirm the transaction.",
            action1: (
              "Open Wallet",
              () => BlockChainRepository.openConnectedWallet(),
              null
            ),
            action2: (
              "Cancel Listing",
              () =>
                  _cancelListVehicle(ipfsCIDS: ipfsCIDS, vehicleID: vehicleID),
              4294198070
            ),
          );
          break;
        case VehicleListingState.verifyPayment:
          loadingCubit.loading(message: "Verifying Payment...");
          break;
      }
    });
    statusStream.push((VehicleListingState.uploadImagesVideos, null));
    final uploadResponse =
        await _uploadInsuranceImage(XFile(vehicleData.insuranceImage ?? ""));
    if (uploadResponse.error != null) {
      return (error: uploadResponse.error);
    }

    ipfsCIDS.add(uploadResponse.cid ?? "");

    if (vehicleImages != null || vehicleVideos != null) {
      final uploadResponse = await _uploadVehicleImagesVideos(
          vehicleImages ?? [], vehicleVideos ?? []);

      vehicleData
        ..vehicleImageUrl = uploadResponse.images
        ..vehicleVideoUrl = uploadResponse.videos;
      ipfsCIDS.addAll(
          [...uploadResponse.images ?? [], ...uploadResponse.videos ?? []]);
    }
    final email = userCubit.state.when<String>(details: (user) => user.email);
    final userID = userCubit.state.userID;
    final response = await vehicleService.listVehicleNoStream(
        userID: userID,
        statusStream: statusStream,
        vehicleData: vehicleData,
        email: email);
    loadingCubit.loaded();
    statusStream.close();

    if (response.error != null) {
      return (error: response.error);
    } else {
      getAllVehicle();
      return (error: null);
    }
  }

  Future<({List<String>? images, List<String>? videos})>
      _uploadVehicleImagesVideos(List<XFile> images, List<XFile> videos) async {
    void handleProgress(double progress) {
      //TODO:show uploading progress to users
    }

    final response = await pinataService.uploadMedia(
        images: images, videos: videos, progress: handleProgress);
    return (images: response.ipfsHashImages, videos: response.ipfsHashVideos);
  }

  Future<({String? error, String? cid})> _uploadInsuranceImage(
    XFile image,
  ) async {
    final response = await pinataService.uploadMedia(images: [image]);
    if (response.error != null) {
      return (error: response.error ?? "", cid: null);
    }
    return (error: null, cid: response.ipfsHashImages?.firstOrNull);
  }

  Future<({String? error, List<(String, String)>? cid})> _uploadTripImages(
    List<(String, XFile)> images,
  ) async {
    final response = await pinataService.uploadMediaWithTitle(images: images);

    return (error: response.error, cid: response.ipfsHashImages);
  }

//TODO:refactor this there're code repetition with getFilteredVehicle
  Future getAllVehicle(
      [({
        List<String>? brand,
        List<String>? type,
        List<String>? capacity,
        ({String? min, String? max}) priceRange
      })? queryOptions]) async {
    emit(VehicleState.loading(
        filterOptions: state.data.$5,
        vehicles: state.data.$1,
        queryOptions: state.data.$4));

    final response = await vehicleService.getListedVehicles(queryOptions);

    if (response.error != null) {
      emit(VehicleState.error(
          message: response.error,
          vehicles: state.data.$1,
          queryOptions: state.data.$4));
    } else {
      List<Vehicle> vehicleList = [];
      final usersLocation = await locationService.getCurrentLocation();
      if (usersLocation.position != null) {
        final usersLatLong = (
          lat: (usersLocation.position!.latitude).toString(),
          long: (usersLocation.position!.longitude).toString()
        );
        vehicleList = _sortByProximity(
            usersLocation: usersLatLong, vehicles: response.vehicle ?? []);
      }

      emit(VehicleState.loaded(
          userLocationKnown: usersLocation.position != null,
          filterOptions: state.data.$5,
          vehicles: vehicleList,
          filteredVehicles: state.data.$3,
          queryOptions: state.data.$4));
      if (state.data.$4 == null) {
        getFilterOptions();
      }
    }
  }

  Future getFilteredVehicle(
      ({
        List<String>? brand,
        List<String>? type,
        List<String>? capacity,
        ({String? min, String? max}) priceRange
      }) queryOptions) async {
    emit(VehicleState.loading(
        filterOptions: state.data.$5,
        vehicles: state.data.$1,
        queryOptions: state.data.$4));

    final response = await vehicleService.getListedVehicles(queryOptions);

    if (response.error != null) {
      emit(VehicleState.error(
          message: response.error,
          vehicles: state.data.$1,
          filterOptions: state.data.$5,
          queryOptions: state.data.$4));
      if (state.data.$4 == null) {
        getFilterOptions();
      }
    } else {
      final newVehicleQueryOptions = VehicleQueryOptions(
        brand: queryOptions.brand,
        type: queryOptions.type,
        capacity: queryOptions.capacity,
        min: queryOptions.priceRange.min,
        max: queryOptions.priceRange.max,
      );

      List<Vehicle> vehicleList = [];
      final usersLocation = await locationService.getCurrentLocation();
      if (usersLocation.position != null) {
        final usersLatLong = (
          lat: (usersLocation.position!.latitude).toString(),
          long: (usersLocation.position!.longitude).toString()
        );
        vehicleList = _sortByProximity(
            usersLocation: usersLatLong, vehicles: response.vehicle ?? []);
      }

      emit(VehicleState.loaded(
          userLocationKnown: usersLocation.position != null,
          filterOptions: state.data.$5,
          vehicles: state.data.$1,
          filteredVehicles: vehicleList,
          queryOptions: newVehicleQueryOptions));
    }
  }

  Future<void> clearVehicleFilters() async {
    state.maybeMap(
      loading: (_) {
        emit((state as _Loading).copyWith(queryOptions: null));
      },
      loaded: (_) {
        emit((state as _Loaded).copyWith(queryOptions: null));
      },
      error: (_) {
        emit((state as _Error).copyWith(queryOptions: null));
      },
      orElse: () {},
    );
  }

  Vehicle? getVehicleById(String vehicleId) {
    try {
      return state.data.$1.firstWhere(
        (vehicle) => vehicle.id == vehicleId,
      );
    } catch (e) {
      return null;
    }
  }

  List<Vehicle> _sortByProximity(
      {required ({String lat, String long}) usersLocation,
      required List<Vehicle> vehicles}) {
    vehicles.sort(((a, b) {
      final vehicleLocationA = (
        long: (a.parkedLocation?['longitude'] ?? '0').toString(),
        lat: (a.parkedLocation?['latitude'] ?? '0').toString()
      );
      final distanceA =
          locationService.calculateDistanceBetweenGeoLocationsWithHaversine(
        destination: vehicleLocationA,
        origin: usersLocation,
      );
      final vehicleLocationB = (
        long: (b.parkedLocation?['longitude'] ?? '0').toString(),
        lat: (b.parkedLocation?['latitude'] ?? '0').toString()
      );
      final distanceB =
          locationService.calculateDistanceBetweenGeoLocationsWithHaversine(
        destination: vehicleLocationB,
        origin: usersLocation,
      );

      return distanceA.compareTo(distanceB);
    }));
    return vehicles;
  }

  Future<({String? error, String? message})> sendVehicleUnlockOTP(
      [String rentalID = "65c4f3963e610a15a791d01f"]) async {
    final response = await vehicleService.unlockVehicleOTP(rentalID: rentalID);
    return response;
  }

  Future<({String? error, String? message})> verifyVehicleUnlockOTP(
      {String rentalID = "65c4f3963e610a15a791d01f",
      required String token}) async {
    final response = await vehicleService.verifyUnlockVehicleOTP(
        rentalID: rentalID, token: token);
    return response;
  }

  Future<String?> unlockVehicle(String vehicleID) async {
    final response = await vehicleService.unlockVehicle(vehicleId: vehicleID);

    return response.error ?? response.message;
  }

  Future<String?> lockVehicle(String vehicleID) async {
    final response = await vehicleService.lockVehicle(vehicleId: vehicleID);
    return response.error ?? response.message;
  }

  Future<({String? error, SmartCarVehicle? vehicle})> getSmartCarVehicle(
      String vehicleID) async {
    return await vehicleService.getSmartCarVehicleById(vehicleID: vehicleID);
  }
}
