part of 'viewed_vehicle_cubit.dart';

@freezed
class ViewedVehicleState with _$ViewedVehicleState {
  const factory ViewedVehicleState.initial() = _Initial;

  const factory ViewedVehicleState.loaded(
      {required List<String> viewedVehicleIds}) = _Loaded;
}
