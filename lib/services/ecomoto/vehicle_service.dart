import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/data/blockchain/blockchain_repository.dart';
import 'package:emr_005/data/blockchain/contracts/vehicle_smart_contract.dart';
import 'package:emr_005/data/graphql/graphql_repository.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/wallet_connect_modal/wallet_connect_modal_config.dart';
import 'package:emr_005/ecomoto/config/web3/web3_config.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/km_miles_converter.dart';
import 'package:emr_005/utils/stream_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class VehicleService {
  VehicleService();

  // Future<
  //     ({
  //       String? error,
  //       ({
  //         String make,
  //         String modelYear,
  //         String model,
  //         String numberOfSeats,
  //         String vehicleType
  //       })? vehicleData
  //     })> fetchVehicleData(String vin) async {
  //   try {
  //     final response = await HttpRepository.getVehicleData(vin);

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       final make = jsonData['Results'][7]['Value'];
  //       final String numberOfSeats = jsonData['Results'][47]['Value'] ?? "";
  //       final String vehicleType = jsonData['Results'][14]["Value"] ?? "";
  //       final String vehicleModel = jsonData['Results'][9]['Value'] ?? "";
  //       final String modelYear = jsonData['Results'][10]['Value'] ?? "";

  //       if (make == null) {
  //         return (
  //           error:
  //               "Oops! We couldn't find any information for the provided vehicle VIN. Please verify the VIN and try again.",
  //           vehicleData: null
  //         );
  //       }

  //       return (
  //         error: null,
  //         vehicleData: (
  //           make: make.toString(),
  //           modelYear: modelYear,
  //           model: vehicleModel,
  //           numberOfSeats: numberOfSeats,
  //           vehicleType: vehicleType
  //         )
  //       );
  //     } else {
  //       return (
  //         error:
  //             "Oops! We couldn't find any information for the provided vehicle VIN. Please verify the VIN and try again.",
  //         vehicleData: null
  //       );
  //     }
  //   } catch (e) {
  //     return (error: e.toString(), vehicleData: null);
  //   }
  // }

  Future<
      ({
        String? error,
        ({String vehicleId, String owner, String mintId})? data
      })> verifyVehicleTransactionAndExtractData({
    required String transactionHash,
    int maxRetries = 2,
  }) async {
    final vehicleListedEvent = VehicleContract.vehicleListedEvent;
    final vehicleNFTMintedEvent = VehicleContract.vehicleNFTMintedEvent;
    const vehicleListedEventTopic = VehicleContract.vehicleListedEventTopic;
    const vehicleNFTMintedEventTopic =
        VehicleContract.vehicleNFTMintedEventTopic;

    for (int tries = maxRetries; tries > 0; tries--) {
      try {
        final transactionVerificationResult =
            await Web3.verifyTransaction(transactionHash);

        if (transactionVerificationResult.error != null) {
          continue;
        }

        ({String vehicleID, String owner})? vehicleListedEventData;
        ({String tokenID})? vehicleNFTMintedEvenData;

        for (var element in transactionVerificationResult.receipt!.logs) {
          if (element.topics != null && element.data != null) {
            if (element.topics!.contains(vehicleListedEventTopic)) {
              final decoded = vehicleListedEvent.decodeResults(
                  element.topics!, element.data!);

              vehicleListedEventData = (
                owner: (decoded[1] as EthereumAddress).toString(),
                vehicleID:
                    '0x${decoded[0].map((value) => value.toRadixString(16).padLeft(2, '0')).join()}'
              );
            }

            if (element.topics!.contains(vehicleNFTMintedEventTopic)) {
              final decoded = vehicleNFTMintedEvent.decodeResults(
                  element.topics!, element.data!);

              vehicleNFTMintedEvenData =
                  (tokenID: (decoded[0] as BigInt).toString(),);
            }
          }
        }

        if (vehicleListedEventData != null &&
            vehicleNFTMintedEvenData != null) {
          return (
            error: null,
            data: (
              vehicleId: vehicleListedEventData.vehicleID,
              owner: vehicleListedEventData.owner,
              mintId: vehicleNFTMintedEvenData.tokenID,
            ),
          );
        }
      } catch (e) {
        return (error: e.toString(), data: null);
      }
    }

    return (error: AppConstants.appErrorMessage, data: null);
  }

  Future<({String? error, String? transactionId})> listVehicleNoStream(
      {required VehicleModel vehicleData,
      required String email,
      required String userID,
      StreamHandler<(VehicleListingState, String?)>? statusStream}) async {
    String? transactionHash;
    String? vehicleId;

    Future<void> deleteVehicleIfNeeded(String? vehicleId) async {
      if (vehicleId != null) {
        await deleteVehicle(id: vehicleId);
      }
      return;
    }

    try {
      statusStream?.push((VehicleListingState.createVehicleData, null));

      final response =
          await GraphQLRepository.createVehicle(vehicleData, lessorID: userID);
      vehicleId = response.data?['createCar']['id'].toString() ?? "";
      final pricePerHour =
          response.data?['createCar']['pricePerHour'].toString() ?? "";
      final usersEmail = email;

      log("VehicleID $vehicleId", name: "ListVehicle");
      statusStream?.push((VehicleListingState.makePayment, vehicleId));
      transactionHash = await BlockChainRepository.listVehicle(
              vehicleId, usersEmail, pricePerHour)
          .timeout(
        AppConstants.transactionTimeout.seconds,
        onTimeout: () => throw TimeoutException(
            "Connection to wallet timeout, ${AppConstants.appErrorMessage}"),
      );

      await Future.delayed(1.seconds);

      final setApprovalForAllTransactionHash =
          await BlockChainRepository.setApprovalForAll().timeout(
        AppConstants.transactionTimeout.seconds,
        onTimeout: () => throw TimeoutException(
            "Connection to wallet timeout, ${AppConstants.appErrorMessage}"),
      );

      log("TransactionHash $transactionHash", name: 'Vehicle Service');
      log("SetApprovalForAllTransactionHash $setApprovalForAllTransactionHash",
          name: 'Vehicle Service');

      if (transactionHash != null) {
        statusStream?.push((VehicleListingState.verifyPayment, null));
        final verificationResponse =
            await verifyVehicleTransactionAndExtractData(
                transactionHash: transactionHash);

        if (verificationResponse.error != null) {
          throw verificationResponse.error!;
        } else {
          statusStream?.push((VehicleListingState.updateVehicleData, null));

          final web3VehicleOwner = verificationResponse.data!.owner;
          final web3VehicleId = verificationResponse.data!.vehicleId;
          final web3NftTokenID = verificationResponse.data!.mintId;

          await Future.wait([
            GraphQLRepository.updateVehicleBlockchainData(web3VehicleOwner,
                web3NftTokenID, transactionHash, web3VehicleId, vehicleId),
            _createVehicleImageVideo(
                id: vehicleId,
                imageUrl: vehicleData.vehicleImageUrl,
                videoUrl: vehicleData.vehicleVideoUrl)
          ]);

          return (error: null, transactionId: transactionHash.toString());
        }
      } else {
        throw AppConstants.appErrorMessage;
      }
    } on TimeoutException catch (e) {
      await deleteVehicleIfNeeded(vehicleId);

      return (
        error: e.message ?? AppConstants.appErrorMessage,
        transactionId: null
      );
    } on JsonRpcError catch (e) {
      await deleteVehicleIfNeeded(vehicleId);

      return (error: e.message, transactionId: null);
    } catch (e) {
      await deleteVehicleIfNeeded(vehicleId);
      return (error: e.toString(), transactionId: null);
    }
  }

  Future<({String? error, String? transactionId})> listVehicle(
      {required VehicleModel vehicleData,
      required String email,
      required String userID}) async {
    late StreamSubscription<FilterEvent> subscriptionListed;
    late StreamSubscription<FilterEvent> subscriptionNFTMinted;

    final vehicleContract = VehicleContract.contract;
    final vehicleListedEvent = VehicleContract.vehicleListedEvent;
    final vehicleNFTMintedEvent = VehicleContract.vehicleNFTMintedEvent;

    String? transactionHash;
    late String web3VehicleId;
    late String web3VehicleOwner;
    late String web3NftTokenID;
    String? vehicleId;

    final completer = Completer<void>();
    int completedEvents = 0;

    void handleCompletion() {
      completedEvents++;
      if (completedEvents == 2) {
        completer.complete();
      }
    }

    Future<void> deleteVehicleIfNeeded(String? vehicleId) async {
      if (vehicleId != null) {
        //TODO: test this new implementation
        await Future.wait([
          deleteVehicle(id: vehicleId),
          subscriptionListed.cancel(),
          subscriptionNFTMinted.cancel()
        ]);
      }
      return;
    }

    try {
      final response =
          await GraphQLRepository.createVehicle(vehicleData, lessorID: userID);

      vehicleId = response.data?['createCar']['id'].toString() ?? "";
      final pricePerHour =
          response.data?['createCar']['pricePerHour'].toString() ?? "";
      final usersEmail = email;

      log("VehicleID $vehicleId", name: "ListVehicle");

      subscriptionListed = Web3.client
          .events(FilterOptions.events(
              contract: vehicleContract, event: vehicleListedEvent))
          .timeout(AppConstants.transactionConfirmationTimeout.seconds,
              onTimeout: (_) => throw TimeoutException(
                  "Transaction Verification timeout, ${AppConstants.appErrorMessage}"))
          .listen((event) {
        if (event.transactionHash == (transactionHash ?? "")) {
          final decoded =
              vehicleListedEvent.decodeResults(event.topics!, event.data!);
          web3VehicleId = utf8.decode(decoded[0]);
          web3VehicleOwner = (decoded[1] as EthereumAddress).toString();

          handleCompletion();
          subscriptionListed.cancel();
        }
      });

      subscriptionNFTMinted = Web3.client
          .events(FilterOptions.events(
              contract: vehicleContract, event: vehicleNFTMintedEvent))
          .timeout(AppConstants.transactionConfirmationTimeout.seconds,
              onTimeout: (_) => throw TimeoutException(
                  "Transaction Verification timeout, ${AppConstants.appErrorMessage}"))
          .listen((event) {
        if (event.transactionHash == (transactionHash ?? "")) {
          final decoded =
              vehicleNFTMintedEvent.decodeResults(event.topics!, event.data!);

          web3NftTokenID = (decoded[0] as BigInt).toString();
          handleCompletion();
          subscriptionNFTMinted.cancel();
        }
      });

      transactionHash = await BlockChainRepository.listVehicle(
              vehicleId, usersEmail, pricePerHour)
          .timeout(
        AppConstants.transactionTimeout.seconds,
        onTimeout: () => throw TimeoutException(
            "Connection to wallet timeout, ${AppConstants.appErrorMessage}"),
      );
      final setApprovalForAllTransactionHash =
          await BlockChainRepository.setApprovalForAll().timeout(
        AppConstants.transactionTimeout.seconds,
        onTimeout: () => throw TimeoutException(
            "Connection to wallet timeout, ${AppConstants.appErrorMessage}"),
      );

      log("TransactionHash $transactionHash", name: 'Vehicle Service');
      log("SetApprovalForAllTransactionHash $setApprovalForAllTransactionHash",
          name: 'Vehicle Service');

      await completer.future;
      await subscriptionListed.cancel();
      await subscriptionNFTMinted.cancel();

      await GraphQLRepository.updateVehicleBlockchainData(web3VehicleOwner,
          web3NftTokenID, transactionHash!, web3VehicleId, vehicleId);
      await _createVehicleImageVideo(
          id: vehicleId,
          imageUrl: vehicleData.vehicleImageUrl,
          videoUrl: vehicleData.vehicleVideoUrl);

      return (error: null, transactionId: transactionHash.toString());
    } on TimeoutException catch (e) {
      await deleteVehicleIfNeeded(vehicleId);
      return (
        error: e.message ?? AppConstants.appErrorMessage,
        transactionId: null
      );
    } on JsonRpcError catch (e) {
      await deleteVehicleIfNeeded(vehicleId);
      return (error: e.message, transactionId: null);
    } catch (e) {
      await deleteVehicleIfNeeded(vehicleId);
      return (error: e.toString(), transactionId: null);
    }
  }

  Future<({String? error})> deleteVehicle({required String id}) async {
    try {
      await GraphQLRepository.deleteVehicle(id);
      log("vehicle deleted", name: 'Vehicle Service');
      return (error: null);
    } catch (e) {
      return (error: e.toString());
    }
  }

  Future<({String? error})> _createVehicleImageVideo(
      {required String id,
      required List<String>? imageUrl,
      required List<String>? videoUrl}) async {
    try {
      if (imageUrl != null || videoUrl != null) {
        await Future.wait([
          ...?videoUrl?.map((videoUrl) =>
              GraphQLRepository.createVehicleImageVideo(id, null, videoUrl)),
          ...?imageUrl?.map((imageUrl) =>
              GraphQLRepository.createVehicleImageVideo(id, imageUrl, null))
        ]);

        log("vehicle image updated", name: 'Vehicle Service');
      }

      return (error: null);
    } catch (e) {
      return (error: e.toString());
    }
  }

  Future<({String? error, List<Vehicle>? vehicle})> getListedVehicles(
      [({
        List<String>? brand,
        List<String>? type,
        List<String>? capacity,
        ({String? min, String? max}) priceRange
      })? queryOptions,
      String? lessorID]) async {
    try {
      final response =
          await GraphQLRepository.getVehicles(queryOptions, lessorID);

      final vehicles = response.data?['cars'] as List;
      final vehiclesModel = vehicles.map((e) => Vehicle.fromMap(e)).toList();

      return (error: null, vehicle: vehiclesModel);
    } catch (e) {
      log(e.toString());
      return (error: e.toString(), vehicle: null);
    }
  }

  Future<({String? error, String? message})> unlockVehicleOTP(
      {required String rentalID}) async {
    try {
      final response = await GraphQLRepository.vehicleUnlockOTP(rentalID);

      final message =
          response.data?['sendVehicleUnlockOTP']['message'] as String?;

      print(response.data);

      return (error: null, message: message);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error, String? message})> verifyUnlockVehicleOTP(
      {required String rentalID, required String token}) async {
    try {
      final response =
          await GraphQLRepository.verifyVehicleUnlockOTP(rentalID, token);

      print(response.data);

      final status =
          response.data?['verifyVehicleUnlockOTP']['status'] as String?;

      if (status == 'error') {
        return (
          error: response.data?['verifyVehicleUnlockOTP']['message'] as String?,
          message: null
        );
      }

      return (
        error: null,
        message: response.data?['verifyVehicleUnlockOTP']['message'] as String?
      );
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error})> refreshSmartCarToken(
      {required String vehicleId}) async {
    try {
      await GraphQLRepository.refreshSmartCarToken(vehicleId);

      return (error: null,);
    } catch (e) {
      return (error: e.toString());
    }
  }

  Future<({String? error, String? message})> unlockVehicle(
      {required String vehicleId}) async {
    bool triedRefreshing = false;
    Future<({String? error, String? message})> func(String vehicleId) async {
      try {
        final response =
            await GraphQLRepository.unlockSmartCarVehicle(vehicleId);
        final message = response.data?['unLockVehicle']['message'] as String?;

        return (error: null, message: message);
      } catch (e) {
        if (triedRefreshing) {
          rethrow;
        }
        triedRefreshing = true;
        await refreshSmartCarToken(vehicleId: vehicleId);
        return func(vehicleId);
      }
    }

    try {
      return await func(vehicleId);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error, String? message})> lockVehicle(
      {required String vehicleId}) async {
    bool triedRefreshing = false;
    Future<({String? error, String? message})> func(String vehicleId) async {
      try {
        final response = await GraphQLRepository.lockSmartCarVehicle(vehicleId);
        final message = response.data?['lockVehicle']['message'] as String?;

        return (error: null, message: message);
      } catch (e) {
        if (triedRefreshing) {
          rethrow;
        }
        triedRefreshing = true;
        await refreshSmartCarToken(vehicleId: vehicleId);
        return func(vehicleId);
      }
    }

    try {
      return await func(vehicleId);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error, String? message})> updateRentalBeforeStartTrip({
    required String rentalID,
    String? startMillage,
    ({
      String backImage,
      String frontImage,
      String insideImage,
      String leftImage,
      String rightImage
    })? beforeTripImage,
  }) async {
    try {
      final response = await GraphQLRepository.updateRental(
          rentalId: rentalID,
          beforeTripImage: beforeTripImage,
          rentalStatus: RentalStatus.active,
          startMilage: startMillage);

      final message = response.data?['updateRental']['message'] as String?;

      return (error: null, message: message);
    } catch (e) {
      return (error: e.toString(), message: null);
    }
  }

  Future<({String? error, List<Trip>? trips})> getTrips(String userID,
      [RentalStatus? rentalStatus]) async {
    try {
      final response = await GraphQLRepository.getRentals(
          rentalStatus: rentalStatus, lesseeID: userID);
      final rentals = response.data?['rentals'] as List;

      final trips = rentals.map((e) => Trip.fromMap(e)).toList();
      return (error: null, trips: trips);
    } catch (e) {
      return (error: e.toString(), trips: null);
    }
  }

  Future<({String? error, List<Trip>? trips})> getRentals(
      String userID, RentalStatus rentalStatus) async {
    try {
      final response = await GraphQLRepository.getRentals(
          rentalStatus: rentalStatus, lessorID: userID);
      final rentals = response.data?['rentals'] as List;
      final trips = rentals.map((e) => Trip.fromMap(e)).toList();
      return (error: null, trips: trips);
    } catch (e) {
      return (error: e.toString(), trips: null);
    }
  }

  Future<({String? error, String? transactionId, String? rentalID})>
      rentVehicle(
          {required VehicleRentalModel vehicleRentalModel,
          required String userID,
          StreamHandler<VehicleRentingState>? statusStream}) async {
    try {
      final data = vehicleRentalModel;

      statusStream?.push(VehicleRentingState.getApproval);

//TODO get approval for the exacly amount to be paid
      final setApprovalForAllTransactionHash =
          await BlockChainRepository.getERC20Approval().timeout(
        AppConstants.transactionTimeout.seconds,
        onTimeout: () => throw TimeoutException(
            "Connection to wallet timeout, ${AppConstants.appErrorMessage}"),
      );
      log("getERC20Approval $setApprovalForAllTransactionHash",
          name: 'Rent Vehicle');

      await Future.delayed(1.seconds);
      statusStream?.push(VehicleRentingState.makePayment);
      final transactionHash = await BlockChainRepository.rentVehicle(
              data.web3VehicleId!,
              data.rentalStartDateTime!,
              data.rentalEndDateTime!,
              data.rentalDays.toString())
          .timeout(AppConstants.transactionTimeout.seconds,
              onTimeout: () => throw TimeoutException(
                  "Connection to wallet timeout, ${AppConstants.appErrorMessage}"));
      log("Rent Vehicle: $transactionHash", name: "Rent Vehicle");

      statusStream?.push(VehicleRentingState.verifyPayment);
      final response = await Web3.verifyTransaction(transactionHash);
      if (!response.isCompleted) {
        return (error: response.error, transactionId: null, rentalID: null);
      }

      statusStream?.push(VehicleRentingState.createRental);

      final createCarResponse = await GraphQLRepository.createRental(data,
          lessorId: vehicleRentalModel.lessorID!, lesseeID: userID);
      final rentalId = createCarResponse.data?['createRental']['id'] as String;

      log(createCarResponse.data.toString(),
          name: "Rent Vehicle - Create Car Response");

      log(rentalId, name: "Rent Vehicle - Create Car Response");

      statusStream?.push(VehicleRentingState.createEscrow);

      final createEscrowResponse = await GraphQLRepository.createEscrow(
          transactionHash, data.amountToPay.toString(), rentalId);

      log(createEscrowResponse.data.toString());
      return (
        error: null,
        transactionId: transactionHash.toString(),
        rentalID: rentalId
      );
    } on TimeoutException catch (e) {
      log("TimeoutException", name: "Rent Vehicle - error");

      return (
        error: e.message ?? AppConstants.appErrorMessage,
        transactionId: null,
        rentalID: null
      );
    } on JsonRpcError catch (e) {
      log(e.toString(), name: "Rent Vehicle - JsonRpcError");

      return (error: e.message, transactionId: null, rentalID: null);
    } catch (e) {
      log(e.toString(), name: "Rent Vehicle - exception");

      return (error: e.toString(), transactionId: null, rentalID: null);
    }
  }

  Future<({String? error})> verifyDriversLicense() async {
    try {
      final walletAddress = WalletConnectModal.walletAddress;
      final transactionHash = await BlockChainRepository.verifyDriversLicense(
              walletAddress!)
          .timeout(AppConstants.transactionTimeout.seconds,
              onTimeout: () => throw TimeoutException(
                  "Connection to wallet timeout, ${AppConstants.appErrorMessage}"));

      final transactionVerifyCationResponse =
          await Web3.verifyTransaction(transactionHash);

      if (transactionVerifyCationResponse.isCompleted) {
        return (error: null);
      }

      return (error: transactionVerifyCationResponse.error);
    } on TimeoutException catch (e) {
      return (error: e.message ?? AppConstants.appErrorMessage,);
    } on JsonRpcError catch (e) {
      return (error: e.message,);
    } catch (e) {
      return (error: e.toString(),);
    }
  }

  Future<
      ({
        String? error,
        ({List<String> make, List<String> type, List<String> capacity})? data
      })> getVehicleFilterValues() async {
    try {
      final response = await GraphQLRepository.vehicleFilterValues();
      final data = response.data?['cars'] as List;
      final vehicleMake =
          data.map((e) => e['make'].toString()).toSet().toList();
      final vehicleType =
          data.map((e) => e['vehicleType'].toString()).toSet().toList();
      final vehicleCapacity =
          (data.map((e) => e['capacity'].toString()).toSet().toList())..sort();
      return (
        error: null,
        data: (make: vehicleMake, type: vehicleType, capacity: vehicleCapacity)
      );
    } catch (e) {
      return (error: e.toString(), data: null);
    }
  }

  Future<({String? error, List<SmartCarVehicle>? vehicles})> connectSmartCar(
      {required String smartCarToken}) async {
    try {
      //TODO: note for test only
      // if (LocalStorage.smartCarAccessToken != null) {
      //   print(LocalStorage.smartCarAccessToken);
      //   return _getSmartCarVehicleDetails(
      //       token: (access: LocalStorage.smartCarAccessToken!, refresh: ""));
      // }

      final response = await GraphQLRepository.exchangeSmartCar(smartCarToken);
      final accessToken = response.data?['exchange']['access_token'];
      final refreshToken = response.data?['exchange']['refresh_token'];

      LocalStorage.saveSmartCarAccessToken(accessToken);

      return _getSmartCarVehicleDetails(
          token: (access: accessToken, refresh: refreshToken));
    } catch (e) {
      return (error: e.toString(), vehicles: null);
    }
  }

  Future<({String? error, List<SmartCarVehicle>? vehicles})>
      _getSmartCarVehicleDetails(
          {required ({String access, String refresh}) token,
          String? vehicleID}) async {
    try {
      late final List<dynamic> vehicleIds;

      if (vehicleID != null) {
        vehicleIds = [vehicleID];
      } else {
        final response =
            await GraphQLRepository.getAllSmartCarVehicles(token.access);
        vehicleIds =
            response.data?['getAllVehicles']['vehicles'] as List<dynamic>;
      }

      final vehicleDetails = await Future.wait(
        vehicleIds.map((vehicleId) async {
          final response = await GraphQLRepository.getSmartCarVehicleDetails(
            token.access,
            vehicleId,
          );

          final vehicleInfo =
              List<Map>.from(response.data?['getBatchData']['responses']);

          return {
            for (var element in vehicleInfo) element['path']: element['body']
          };
        }),
      );

      final smartCarVehicle = vehicleDetails.map(
        (info) {
          return SmartCarVehicle(
              token: token,
              vin: info['/vin']['vin'],
              odometer: info['/odometer']['distance'],
              id: info['/']['id'],
              make: info['/']['make'],
              model: info['/']['model'],
              chargingStatus: (
                isPluggedIn: info['/charge']['isPluggedIn'],
                state: info['/charge']['state']
              ),
              batteryCapacity: info['/battery/capacity']['capacity'].toString(),
              battery: (
                percentRemaining:
                    info['/battery']['percentRemaining'].toString(),
                range: convertKilometersToMiles(
                    info['/battery']['range'].toString())
              ),
              location: LatLng(info['/location']['latitude'],
                  info['/location']['longitude']),
              year: info['/']['year'].toString());
        },
      ).toList();

      return (error: null, vehicles: smartCarVehicle);
    } catch (e) {
      return (error: e.toString(), vehicles: null);
    }
  }

  Future<({String? error, SmartCarVehicle? vehicle})> getSmartCarVehicleDetails(
      {required ({String access, String refresh}) token,
      required String vehicleID}) async {
    final response =
        await _getSmartCarVehicleDetails(token: token, vehicleID: vehicleID);

    return (error: response.error, vehicle: response.vehicles?.firstOrNull);
  }

  Future<({String? error, SmartCarVehicle? vehicle})> getSmartCarVehicleById(
      {required String vehicleID}) async {
    bool triedRefreshing = false;

    Future<QueryResult<Object?>> func(String vehicleId) async {
      try {
        return await GraphQLRepository.getSmartCarVehicleDetails(
          null,
          vehicleID,
        );
      } catch (e) {
        if (triedRefreshing) {
          rethrow;
        }
        triedRefreshing = true;

        await refreshSmartCarToken(vehicleId: vehicleId);
        return func(vehicleID);
      }
    }

    try {
      final response = await func(
        vehicleID,
      );

      final vehicleInfo =
          List<Map>.from(response.data?['lesseeGetBatchData']['responses']);
      final Map<String, dynamic> pathBodyMap = {};

      for (var element in vehicleInfo) {
        final path = element['path'];
        final body = element['body'];
        pathBodyMap[path] = body;
      }

      final smartCarVehicle = SmartCarVehicle(
          token: null,
          odometer: pathBodyMap['/odometer']['distance'],
          vin: pathBodyMap['/vin']['vin'],
          id: pathBodyMap['/']['id'],
          make: pathBodyMap['/']['make'],
          model: pathBodyMap['/']['model'],
          chargingStatus: (
            isPluggedIn: pathBodyMap['/charge']['isPluggedIn'],
            state: pathBodyMap['/charge']['state']
          ),
          batteryCapacity:
              pathBodyMap['/battery/capacity']['capacity'].toString(),
          battery: (
            percentRemaining:
                pathBodyMap['/battery']['percentRemaining'].toString(),
            range: convertKilometersToMiles(
                pathBodyMap['/battery']['range'].toString())
          ),
          location: LatLng(pathBodyMap['/location']['latitude'],
              pathBodyMap['/location']['longitude']),
          year: pathBodyMap['/']['year'].toString());

      return (error: null, vehicle: smartCarVehicle);
    } catch (e) {
      return (error: e.toString(), vehicle: null);
    }
  }
}
