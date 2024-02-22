part of 'trips_cubit.dart';

@freezed
class TripsState with _$TripsState {
  const TripsState._();

  const factory TripsState.initial() = _Initial;
  const factory TripsState.loading({
    required List<Trip> active,
    required List<Trip> history,
    required List<Trip> booked,
  }) = _Loading;
  const factory TripsState.loaded({
    required List<Trip> active,
    required List<Trip> history,
    required List<Trip> booked,
  }) = _Loaded;
  const factory TripsState.error({
    required String errorMessage,
    required List<Trip> active,
    required List<Trip> history,
    required List<Trip> booked,
  }) = _Error;

  bool get isEmptyData {
    return maybeWhen(
      orElse: () => false,
      loaded: (history, active, booked) => history.isEmpty && active.isEmpty,
    );
  }

  bool get hasActiveRental {
    return maybeMap<bool>(
      error: (state) => state.active.isNotEmpty,
      loading: (state) => state.active.isNotEmpty,
      orElse: () => false,
      loaded: (state) => state.active.isNotEmpty,
    );
  }

  ({List<Trip> trips, List<Trip> history, List<Trip> booked}) get data {
    return maybeWhen(
      orElse: () => (trips: [], history: [], booked: []),
      loaded: (
        trips,
        history,
        booked,
      ) =>
          (trips: trips, history: history, booked: booked),
      loading: (
        trips,
        history,
        booked,
      ) =>
          (trips: trips, history: history, booked: booked),
      error: (
        message,
        trips,
        history,
        booked,
      ) =>
          (trips: trips, history: history, booked: booked),
    );
  }

  Trip? get activeTripData {
    return hasActiveRental ? data.trips.firstOrNull : null;
  }

  factory TripsState.fromJson(Map<String, Object?> json) =>
      _$TripsStateFromJson(json);
}
