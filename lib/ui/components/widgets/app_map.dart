import 'package:emr_005/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMap extends StatelessWidget {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final Set<Circle>? circles;
  final void Function(GoogleMapController)? onMapCreated;
  final CameraPosition? initialCameraPosition;

  const AppMap({
    super.key,
    required this.markers,
    required this.polylines,
    this.circles = const <Circle>{},
    this.onMapCreated,
    this.initialCameraPosition,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      circles: circles ?? <Circle>{},
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      buildingsEnabled: false,
      trafficEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: true,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      markers: markers,
      polylines: polylines,
      mapType: MapType.terrain,
      onMapCreated: onMapCreated ?? (GoogleMapController controller) {},
      initialCameraPosition: initialCameraPosition ??
          const CameraPosition(
            target: AppConstants.defaultLocation,
            zoom: 16.0,
          ),
    );
  }
}
