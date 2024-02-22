part of 'host_cubit.dart';

@freezed
class HostState with _$HostState {
  const HostState._();
  const factory HostState.initial() = _Initial;
  const factory HostState.loading({
    required List<Vehicle> activeVehicles,
    required List<Vehicle> disabledVehicles,
    required List<Trip> activeRental,
    required List<Trip> bookedRental,
  }) = _Loading;
  const factory HostState.loaded({
    required List<Trip> activeRental,
    required List<Trip> bookedRental,
    required List<Vehicle> activeVehicles,
    required List<Vehicle> disabledVehicles,
  }) = _Loaded;
  const factory HostState.error({
    required String errorMessage,
    required List<Trip> activeRental,
    required List<Trip> bookedRental,
    required List<Vehicle> activeVehicles,
    required List<Vehicle> disabledVehicles,
  }) = _Error;

  ({
    List<Vehicle> activeVehicles,
    List<Vehicle> disabledVehicles,
    List<Trip> activeRental,
    List<Trip> bookedRental
  }) get data {
    return maybeWhen(
      orElse: () => (
        activeVehicles: [],
        disabledVehicles: [],
        activeRental: [],
        bookedRental: []
      ),
      loading: (
        activeVehicles,
        disabledVehicles,
        activeRental,
        bookedRental,
      ) =>
          (
        activeVehicles: activeVehicles,
        disabledVehicles: disabledVehicles,
        activeRental: activeRental,
        bookedRental: bookedRental
      ),
      loaded: (activeRental, bookedRental, activeVehicles, disabledVehicles) =>
          (
        activeVehicles: activeVehicles,
        disabledVehicles: disabledVehicles,
        activeRental: activeRental,
        bookedRental: bookedRental
      ),
      error: (
        _,
        activeRental,
        bookedRental,
        activeVehicles,
        disabledVehicles,
      ) =>
          (
        activeVehicles: activeVehicles,
        disabledVehicles: disabledVehicles,
        activeRental: activeRental,
        bookedRental: bookedRental
      ),
    );
  }
}
