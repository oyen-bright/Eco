// import 'package:emr_005/extensions/context.dart';
// import 'package:emr_005/services/location_service.dart';
// import 'package:emr_005/utils/enums.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';

// class PermissionController {
//   late final ValueNotifier<bool> _locationPermissionNotifier;

//   PermissionController()
//       : _locationPermissionNotifier = ValueNotifier<bool>(false);

//   ValueNotifier<bool> get locationPermissionNotifier =>
//       _locationPermissionNotifier;

//   bool get hasLocationPermission => _locationPermissionNotifier.value;

//   void updateLocationPermissionStatus(bool newStatus) {
//     _locationPermissionNotifier.value = newStatus;
//   }

//   Future<bool> requestPermission(BuildContext context) async {
//     final response =
//         await context.read<LocationService>().checkLocationPermission();

//     if (!response.isGranted && context.mounted) {
//       if (response.status == null) {
//         Future.microtask(() => context.showSnackBar(
//             response.error,
//             BarType.action,
//             const SnackBarAction(
//                 label: "enable", onPressed: Geolocator.openLocationSettings)));
//         return false;
//       } else {
//         Future.microtask(() => context.showSnackBar(
//             response.error,
//             BarType.action,
//             const SnackBarAction(
//                 label: "enable", onPressed: Geolocator.openAppSettings)));
//         return false;
//       }
//     }
//     updateLocationPermissionStatus(true);
//     return true;
//   }

//   void dispose() {
//     _locationPermissionNotifier.dispose();
//   }
// }
