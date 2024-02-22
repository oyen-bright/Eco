part of 'vehicle_cubit.dart';

@freezed
class VehicleState with _$VehicleState {
  const VehicleState._();

  const factory VehicleState.initial() = _Initial;

  const factory VehicleState.loading(
      {required List<Vehicle> vehicles,
      required VehicleQueryOptions? queryOptions,
      required ({
        List<String> make,
        List<String> type,
        List<String> capacity
      })? filterOptions}) = _Loading;

  const factory VehicleState.loaded(
      {required List<Vehicle> vehicles,
      required bool userLocationKnown,
      required List<Vehicle> filteredVehicles,
      required VehicleQueryOptions? queryOptions,
      required ({
        List<String> make,
        List<String> type,
        List<String> capacity
      })? filterOptions}) = _Loaded;

  const factory VehicleState.error(
      {String? message,
      List<Vehicle>? vehicles,
      VehicleQueryOptions? queryOptions,
      ({
        List<String> make,
        List<String> type,
        List<String> capacity
      })? filterOptions}) = _Error;

  // factory VehicleState.fromJson(Map<String, dynamic> json) =>
  //     _$VehicleStateFromJson(json);

  int? get filterCount {
    int? counter(VehicleQueryOptions? queryOptions) {
      if (queryOptions == null) {
        return null;
      }
      int count = 0;
      count += (queryOptions.brand?.isNotEmpty ?? false) ? 1 : 0;
      count += (queryOptions.type?.isNotEmpty ?? false) ? 1 : 0;
      count += (queryOptions.capacity?.isNotEmpty ?? false) ? 1 : 0;
      count += ((queryOptions.max?.isNotEmpty ?? false) ||
              (queryOptions.min?.isNotEmpty ?? false))
          ? 1
          : 0;
      return count;
    }

    return map(
        initial: (_) => null,
        loading: (loading) {
          return counter(loading.queryOptions);
        },
        loaded: (loaded) {
          return counter(loaded.queryOptions);
        },
        error: (error) {
          return counter(error.queryOptions);
        });
  }

  bool get isNearbyVehicles {
    return maybeMap(
        orElse: () => false, loaded: (state) => state.userLocationKnown);
  }

  (
    List<Vehicle> vehicles,
    bool? userLocationKnown,
    List<Vehicle> filteredVehicles,
    VehicleQueryOptions? queryOptions,
    ({List<String> make, List<String> type, List<String> capacity})?
  ) get data {
    return maybeWhen<
        (
          List<Vehicle>,
          bool?,
          List<Vehicle>,
          VehicleQueryOptions?,
          ({List<String> make, List<String> type, List<String> capacity})?
        )>(
      orElse: () => ([], null, [], null, null),
      loaded: (vehicles, userLocationKnown, filteredVehicle, queryOptions,
              filterOptions) =>
          (
        vehicles,
        userLocationKnown,
        filteredVehicle,
        queryOptions,
        filterOptions
      ),
      loading: (vehicles, queryOptions, filterOptions) => (
        vehicles,
        null,
        [],
        queryOptions,
        filterOptions,
      ),
      error: (message, vehicles, queryOptions, filterOptions) =>
          (vehicles ?? [], null, [], queryOptions, filterOptions),
    );
  }
}
