import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'trip_model.dart';

part 'trips_cubit.freezed.dart';
part 'trips_cubit.g.dart';
part 'trips_state.dart';

// class TripsCubit extends Cubit<TripsState> {
//   final VehicleService vehicleService;
//   final UserCubit userCubit;
//   TripsCubit(this.vehicleService, this.userCubit)
//       : super(const TripsState.initial()) {
//     getData();
//   }

//   Future<void> getData() async {
//     await getTrips();
//     await getHistory();
//   }

//   Future<void> getTrips() async {
//     emit(TripsState.loading(
//         booked: state.data.booked,
//         active: state.data.trips,
//         history: state.data.history));

//     final userID = userCubit.state.userID;
//     final response = await vehicleService.getTrips(userID, RentalStatus.active);
//     if (response.error == null) {
//       emit(TripsState.loaded(
//           active: response.trips ?? [],
//           history: state.data.history,
//           booked: []));
//       return;
//     }
//     emit(TripsState.error(
//         errorMessage: response.error ?? "",
//         active: state.data.trips,
//         history: state.data.history,
//         booked: []));
//   }

//   Future<void> getHistory() async {
//     emit(TripsState.loading(
//         active: state.data.trips, history: state.data.history, booked: []));

//     final userID = userCubit.state.userID;

//     final response = await vehicleService.getTrips(userID);
//     if (response.error == null) {
//       emit(TripsState.loaded(
//           active: state.data.trips,
//           history: response.trips?.reversed.toList() ?? [],
//           booked: []));
//       return;
//     }
//     emit(TripsState.error(
//         errorMessage: response.error ?? "",
//         active: state.data.trips,
//         history: state.data.history,
//         booked: []));
//   }

//   @override
//   TripsState? fromJson(Map<String, dynamic> json) {
//     throw TripsState.fromJson(json);
//   }

//   @override
//   Map<String, dynamic>? toJson(TripsState state) {
//     throw state.toJson();
//   }
// }

class TripsCubit extends Cubit<TripsState> {
  final VehicleService vehicleService;
  final UserCubit userCubit;

  TripsCubit(this.vehicleService, this.userCubit)
      : super(const TripsState.initial()) {
    getData();
  }

  Future<void> getData() async {
    await getTrips();
    await getHistory();
    await getBooked();
  }

  Future<void> getTrips() async {
    emitLoadingState();
    final userID = userCubit.state.userID;
    final response = await vehicleService.getTrips(userID, RentalStatus.active);

    if (response.error == null) {
      final trips = response.trips?.reversed.toList();
      emitLoadedState(
        active: trips ?? [],
      );
    } else {
      emitErrorState(errorMessage: response.error ?? "");
    }
  }

  Future<void> getBooked() async {
    emitLoadingState();
    final userID = userCubit.state.userID;
    final response = await vehicleService.getTrips(userID, RentalStatus.booked);

    if (response.error == null && response.trips != null) {
      final isReady = response.trips!
          .where((e) {
            return e.rentalStartDatetime.isBefore(DateTime.now()) ||
                e.rentalStartDatetime.isAtSameMomentAs(DateTime.now());
          })
          .map((e) => e.copyWith(rentalStatus: RentalStatus.ready))
          .toList();

      final booked = response.trips!.where((e) {
        return e.rentalStartDatetime.isAfter(DateTime.now());
      }).toList();
      emitLoadedState(booked: booked, active: isReady);
    } else {
      emitErrorState(errorMessage: response.error ?? "");
    }
  }

  Future<void> getHistory() async {
    emitLoadingState();
    final userID = userCubit.state.userID;
    final response =
        await vehicleService.getTrips(userID, RentalStatus.completed);

    if (response.error == null) {
      emitLoadedState(history: response.trips?.reversed.toList() ?? []);
    } else {
      emitErrorState(errorMessage: response.error ?? "");
    }
  }

  void emitLoadingState() {
    emit(TripsState.loading(
      active: state.data.trips,
      history: state.data.history,
      booked: state.data.booked,
    ));
  }

  void emitLoadedState({
    List<Trip>? active,
    List<Trip>? history,
    List<Trip>? booked,
    RentalStatus? status,
  }) {
    emit(TripsState.loaded(
      active: active ?? state.data.trips,
      history: history ?? state.data.history,
      booked: booked ?? state.data.booked,
    ));
  }

  void emitErrorState({String errorMessage = ""}) {
    emit(TripsState.error(
      errorMessage: errorMessage,
      active: state.data.trips,
      history: state.data.history,
      booked: state.data.booked,
    ));
  }
}
