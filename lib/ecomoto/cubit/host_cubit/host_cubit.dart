import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_cubit.freezed.dart';
part 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  final VehicleService vehicleService;
  final UserCubit userCubit;

  HostCubit(this.vehicleService, this.userCubit)
      : super(const HostState.initial()) {
    getData();
  }

  Future<void> getData() async {
    getVehicles();
    getRentals();
  }

  Future<void> getVehicles() async {
    emitLoadingState();
    final userID = userCubit.state.userID;
    final response = await vehicleService.getListedVehicles(null, userID);

    if (response.error != null) {
      emitErrorState(response.error!);
      return;
    }

    emitLoadedState(activeVehicles: response.vehicle ?? []);
  }

  Future<void> getRentals() async {
    getActiveRentals();
    getBookedRentals();
  }

  Future<void> getActiveRentals() async {
    emitLoadingState();
    final userID = userCubit.state.userID;

    final response =
        await vehicleService.getRentals(userID, RentalStatus.active);

    if (response.error != null) {
      emitErrorState(response.error!);
      return;
    }

    emitLoadedState(activeRental: response.trips ?? []);
  }

  Future<void> getBookedRentals() async {
    emitLoadingState();
    final userID = userCubit.state.userID;

    final response =
        await vehicleService.getRentals(userID, RentalStatus.completed);

    if (response.error != null) {
      emitErrorState(response.error!);
      return;
    }

    emitLoadedState(bookedRental: response.trips ?? []);
  }

  bool get hasListedVehicles {
    if (state is _Loaded) {
      return state.data.activeVehicles.isNotEmpty;
    }

    return true;
  }

  void emitLoadingState() {
    emit(HostState.loading(
      activeRental: state.data.activeRental,
      bookedRental: state.data.bookedRental,
      activeVehicles: state.data.activeVehicles,
      disabledVehicles: state.data.disabledVehicles,
    ));
  }

  void emitErrorState(String error) {
    emit(HostState.error(
      errorMessage: error,
      activeRental: state.data.activeRental,
      bookedRental: state.data.bookedRental,
      activeVehicles: state.data.activeVehicles,
      disabledVehicles: state.data.disabledVehicles,
    ));
  }

  void emitLoadedState({
    List<Trip>? activeRental,
    List<Trip>? bookedRental,
    List<Vehicle>? activeVehicles,
    List<Vehicle>? disabledVehicles,
  }) {
    emit(HostState.loaded(
      activeRental: activeRental ?? state.data.activeRental,
      bookedRental: bookedRental ?? state.data.bookedRental,
      activeVehicles: activeVehicles ?? state.data.activeVehicles,
      disabledVehicles: disabledVehicles ?? state.data.disabledVehicles,
    ));
  }
}
