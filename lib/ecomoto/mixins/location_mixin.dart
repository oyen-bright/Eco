import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

mixin LocationMixin {
  String formatPlace(List<Placemark> placeMark) {
    return [
      // Uncomment or add other fields as needed
      // if (placeMark.name != null) placeMark.name,
      if (placeMark.first.subThoroughfare != null)
        placeMark.first.subThoroughfare!,
      if (placeMark.first.thoroughfare != null) placeMark.first.thoroughfare!,
      if (placeMark.first.subLocality != null) placeMark.first.subLocality!,
      if (placeMark.first.locality != null) placeMark.first.locality!,
      if (placeMark.first.administrativeArea != null)
        placeMark.first.administrativeArea!,
      if (placeMark.first.country != null) placeMark.first.country!,
    ].where((element) => element.isNotEmpty).join(', ');
  }

  ({String mainTown, String fullAddress}) formatPlaceWithTown(
      List<Placemark> placeMark) {
    final placeDetails = placeMark.first;

    final mainTown = placeDetails.locality ?? placeDetails.subLocality ?? '';
    List<String> components = [
      placeDetails.subLocality ?? '',
      placeDetails.locality ?? '',
      placeDetails.subAdministrativeArea ?? '',
      placeDetails.country ?? '',
      placeDetails.postalCode ?? '',
    ];

    List<String> nonEmptyComponents =
        components.where((component) => component.isNotEmpty).toList();

    final fullAddress = nonEmptyComponents.join(', ');
    return (mainTown: mainTown, fullAddress: fullAddress);
  }

  Future<bool> requestLocationPermission(BuildContext context) async {
    final response =
        await context.read<LocationService>().checkLocationPermission();

    if (!response.isGranted && context.mounted) {
      if (response.status == null) {
        Future.microtask(() => context.showSnackBar(
            response.error,
            BarType.action,
            const SnackBarAction(
                label: "enable", onPressed: Geolocator.openLocationSettings)));
        return false;
      } else {
        Future.microtask(() => context.showSnackBar(
            response.error,
            BarType.action,
            const SnackBarAction(
                label: "enable", onPressed: Geolocator.openAppSettings)));
        return false;
      }
    }
    return true;
  }
}
