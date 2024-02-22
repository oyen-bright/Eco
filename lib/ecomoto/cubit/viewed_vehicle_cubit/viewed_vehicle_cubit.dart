import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../vehicle_cubit/vehicle_cubit.dart';
import '../vehicle_cubit/vehicle_model.dart';

part 'viewed_vehicle_cubit.freezed.dart';
part 'viewed_vehicle_state.dart';

//TODO: consider switching to hydared bloc instead of local storage

class ViewedVehicleCubit extends Cubit<ViewedVehicleState> {
  ViewedVehicleCubit() : super(const ViewedVehicleState.initial());

  void reload(VehicleState vehicleState) {
    final recentlyViewedVehicles = state.when(
      initial: () => LocalStorage.recentlyViewedVehicles,
      loaded: (List<String> data) => data,
    );

    vehicleState.when(
      initial: () => {},
      loading: (vehicles, filteredVehicles, _) =>
          _syncViewedVehicles(vehicles, recentlyViewedVehicles),
      loaded: (vehicles, _, filteredVehicles, __, ___) =>
          _syncViewedVehicles(vehicles, recentlyViewedVehicles),
      error: (message, vehicles, _, __) =>
          _syncViewedVehicles(vehicles ?? [], recentlyViewedVehicles),
    );
  }

  void _syncViewedVehicles(
      List<Vehicle> vehicles, List<String> viewedVehicleIds) {
    final validViewedIds = viewedVehicleIds
        .where((id) => vehicles.any((vehicle) => vehicle.id == id))
        .toList();

    emit(ViewedVehicleState.loaded(viewedVehicleIds: validViewedIds));
  }

  void addViewedVehicle(String vehicleId) async {
    final currentList = state.maybeWhen(
      loaded: (viewedVehicleIds) => viewedVehicleIds,
      orElse: () => <String>[],
    );

    if (currentList.contains(vehicleId)) {
      final updatedList = [
        vehicleId,
        ...currentList.where((id) => id != vehicleId)
      ];
      await LocalStorage.onRecentlyViewedVehicle(vehicleId);
      emit(ViewedVehicleState.loaded(viewedVehicleIds: updatedList));
    } else {
      final updatedList = [vehicleId, ...currentList];

      if (updatedList.length > 10) {
        updatedList.removeLast();
      }

      await LocalStorage.onRecentlyViewedVehicle(vehicleId);
      emit(ViewedVehicleState.loaded(viewedVehicleIds: updatedList));
    }
  }

  void removeViewedVehicle(String vehicleId) async {
    final currentList = state.maybeWhen(
      loaded: (viewedVehicleIds) => viewedVehicleIds,
      orElse: () => <String>[],
    );
    final updatedList = currentList.where((id) => id != vehicleId).toList();
    await LocalStorage.onRecentlyViewedVehicle(vehicleId, StorageAction.remove);

    emit(ViewedVehicleState.loaded(viewedVehicleIds: updatedList));
  }

  void clearViewedVehicles() async {
    await LocalStorage.onRecentlyViewedVehicle(null, StorageAction.clear);

    emit(const ViewedVehicleState.loaded(viewedVehicleIds: []));
  }
}
