//LEGACY CODE
// part of locate_vehicle;

// class LocateVehicleMap extends StatefulWidget {
//   final Vehicle vehicle;
//   const LocateVehicleMap({Key? key, required this.vehicle}) : super(key: key);

//   @override
//   State<LocateVehicleMap> createState() => LocateVehicleMapState();
// }

// class LocateVehicleMapState extends State<LocateVehicleMap> {
//   Timer? _timer;
//   Marker? _userLocationMarker;
//   Set<Polyline> _polylines = {};
//   bool _isFetching = false;

//   bool isFetchingLocation = false;
//   LatLng userCurrentLocation = const LatLng(0, 0);
//   String distanceLeft = '';
//   String durationLeft = '';

//   final int maxInterval = 10;
//   final int minInterval = 5;

//   late ScaffoldMessengerState _scaffoldMessenger;
//   late final BitmapDescriptor _vehicleMarker;
//   late final LatLng vehicleLocation;
//   final Completer<GoogleMapController> _mapController = Completer();
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       loadResources().then((_) => (VehicleLocatedBottomSheet(
//             vehicle: widget.vehicle,
//           ).asBottomSheet(context).then((value) async {
//             await _fetchCurrentLocation();
//             _startTrackingUsersLocation();
//           })));
//     });
//   }

//   Future<void> loadResources() async {
//     _vehicleMarker = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       AppImages.vehicleMarkerImage,
//     );
//     final parkedLocation = widget.vehicle.parkedLocation!;
//     final vehicleLatitude = parkedLocation['latitude'];
//     final vehicleLongitude = parkedLocation['longitude'];
//     vehicleLocation = LatLng(vehicleLatitude, vehicleLongitude);
//     setState(() {
//       _markers.add(Marker(
//         markerId: const MarkerId('destination'),
//         icon: _vehicleMarker,
//         position: vehicleLocation,
//         infoWindow: const InfoWindow(title: 'Vehicle Location'),
//       ));
//     });
//     return;
//   }

//   void showErrors(String error, bool hasLocationPermission) {
//     var button = TextButton(
//         onPressed: () {
//           _scaffoldMessenger.clearMaterialBanners();
//           _fetchCurrentLocation(showLoadingIndicator: true);
//         },
//         child: const Text("RETRY"));
//     context.showBanner(error, [button]);
//     if (!hasLocationPermission) {
//       context.showSnackBar(error, BarType.action,
//           const SnackBarAction(label: "enable", onPressed: openAppSettings));
//     }
//   }

//   void _startTrackingUsersLocation([int? interval]) {
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: interval ?? 20), (_) {
//       if (!_isFetching) {
//         _fetchCurrentLocation(showLoadingIndicator: false);
//       }
//     });
//   }

//   void updateTimerInterval(double newDistance) {
//     int newInterval = calculateInterval(newDistance);

//     _startTrackingUsersLocation(newInterval);
//   }

//   int calculateInterval(double distance) {
//     const double farDistanceThreshold = 1000;
//     const double nearDistanceThreshold = 100;

//     if (distance >= farDistanceThreshold) {
//       return maxInterval;
//     } else if (distance <= nearDistanceThreshold) {
//       return minInterval;
//     } else {
//       double scale = (distance - nearDistanceThreshold) /
//           (farDistanceThreshold - nearDistanceThreshold);
//       return minInterval + ((maxInterval - minInterval) * scale).toInt();
//     }
//   }

//   Future<void> _fetchCurrentLocation({bool showLoadingIndicator = true}) async {
//     if (_isFetching) return;

//     _isFetching = true;
//     showLoadingIndicator ? setState(() => isFetchingLocation = true) : null;

//     final response = await context
//         .read<LocationService>()
//         .getCurrentLocation(LocationAccuracy.best);

//     if (response.error == null && response.position != null) {
//       final usersLatestLocation = LatLng(
//           response.position?.latitude ?? 0, response.position?.longitude ?? 0);
//       print(usersLatestLocation);
//       print(usersLatestLocation);
//       if (usersLatestLocation != userCurrentLocation) {
//         userCurrentLocation = usersLatestLocation;
//         _updateCameraPosition();
//         await _getDirections(userCurrentLocation, vehicleLocation);
//       }
//     } else {
//       showErrors(response.error!, response.hasPermission ?? true);
//     }

//     showLoadingIndicator ? setState(() => isFetchingLocation = false) : null;
//     _isFetching = false;
//     return;
//   }

//   Future<void> _updateCameraPosition() async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition cameraPosition = CameraPosition(
//       target: userCurrentLocation,
//       zoom: 18,
//       // bearing: 90,
//       // tilt: 90,
//     );
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }

//   Future<void> _getDirections(
//       LatLng userLocation, LatLng vehicleLocation) async {
//     _userLocationMarker = Marker(
//       markerId: const MarkerId('origin'),
//       position: userLocation,
//       infoWindow: const InfoWindow(title: 'Your Location'),
//     );
//     _markers.add(_userLocationMarker!);

//     if (mounted) {
//       final response = await context
//           .read<LocationService>()
//           .getDirectionBetweenGeoLocations(
//               originLatLng: userLocation, destinationLatLng: vehicleLocation);

//       if (response.error == null) {
//         final distance = response.data!.distance;
//         final duration = response.data!.duration;
//         final steps = response.data!.steps;
//         _processDirectionsResponse(distance, duration, steps);
//       } else {
//         showErrors(Strings.directionErrorText, true);
//       }
//     }
//   }

//   void _processDirectionsResponse(
//       String distance, String duration, List<dynamic> steps) {
//     double distanceValue = _parseDistance(distance);

//     if (distanceValue <= AppConstants.distanceToUnlockVehicle) {
//       _timer?.cancel();
//       _showBottomSheet();
//     } else {
//       updateTimerInterval(distanceValue);
//     }

//     List<LatLng> polylinePoints = _decodePolylinePoints(steps);

//     setState(() {
//       _polylines = {
//         ..._polylines,
//         Polyline(
//           polylineId: const PolylineId('route'),
//           points: polylinePoints,
//           color: AppColors.rentalUsedColor,
//           width: 10,
//         )
//       };
//       distanceLeft = distance;
//       durationLeft = duration;
//     });
//   }

//   double _parseDistance(String distance) {
//     double distanceValue = 0.0;
//     if (distance.contains('km')) {
//       distanceValue =
//           double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
//       distanceValue *= 1000;
//     } else if (distance.contains('m')) {
//       distanceValue =
//           double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
//     }
//     return distanceValue;
//   }

//   List<LatLng> _decodePolylinePoints(List<dynamic> steps) {
//     List<LatLng> polylinePoints = [];
//     for (var step in steps) {
//       String points = step['polyline']['points'];
//       List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
//       for (var point in decodedPoints) {
//         polylinePoints.add(LatLng(point.latitude, point.longitude));
//       }
//     }
//     return polylinePoints;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final key = context.read<AppScaffoldController>().key.currentContext;
//     key != null ? _scaffoldMessenger = ScaffoldMessenger.of(key) : null;
//   }

//   @override
//   void dispose() {
//     _scaffoldMessenger.clearMaterialBanners();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [_buildGoogleMap(size), _buildDistance()],
//         ),
//         if (isFetchingLocation) const Positioned.fill(child: LoadingOverlay())
//       ],
//     );
//   }

//   DistanceContainerWidget _buildDistance() {
//     return DistanceContainerWidget(
//         distanceLeftString: distanceLeft, durationLeftString: durationLeft);
//   }

//   Widget _buildGoogleMap(Size size) {
//     return Expanded(
//       child: GoogleMap(
//         trafficEnabled: true,
//         mapToolbarEnabled: false,
//         zoomControlsEnabled: true,
//         compassEnabled: true,
//         zoomGesturesEnabled: true,
//         markers: _markers,
//         polylines: _polylines,
//         mapType: MapType.terrain,
//         onMapCreated: (GoogleMapController controller) {
//           _mapController.complete(controller);
//         },
//         initialCameraPosition: const CameraPosition(
//           target: AppConstants.defaultLocation,
//           zoom: 16.0,
//         ),
//       ),
//     );
//   }

//   void _showBottomSheet() {
//     VehicleLocatedGetCode(
//       vehicle: widget.vehicle,
//     ).asBottomSheet(
//       context,
//       isDismissible: false,
//       enableDrag: false,
//       backgroundColor: Colors.transparent,
//     );
//   }
// }

part of locate_vehicle;

class LocateVehicleMap extends StatefulWidget {
  final Vehicle vehicle;
  final String rentalID;
  const LocateVehicleMap(
      {Key? key, required this.vehicle, required this.rentalID})
      : super(key: key);

  @override
  State<LocateVehicleMap> createState() => LocateVehicleMapState();
}

class LocateVehicleMapState extends State<LocateVehicleMap> with LocationMixin {
  Set<Polyline> _polylines = {};
  // Marker? _userLocationMarker;
  bool isFetchingLocation = false;
  LatLng? userCurrentLocation;

  String? distanceLeft;
  String? durationLeft;
  int distanceFilter = 10;

  late ScaffoldMessengerState _scaffoldMessenger;
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};
  late final BitmapDescriptor _vehicleMarker;
  late final LatLng vehicleLocation;

  StreamSubscription<Position>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadResources().then((_) {
        VehicleLocatedBottomSheet(
          vehicle: widget.vehicle,
        ).asBottomSheet(context).then((value) {
          _showBottomSheet();
          _startTrackingUsersLocation();
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final key = context.read<AppScaffoldController>().key.currentContext;
    key != null ? _scaffoldMessenger = ScaffoldMessenger.of(key) : null;
  }

  @override
  void dispose() {
    _scaffoldMessenger.clearMaterialBanners();
    _positionSubscription?.cancel();
    super.dispose();
  }

  void _showErrors(String error, bool hasLocationPermission) {
    var button = TextButton(
        onPressed: () {
          _scaffoldMessenger.clearMaterialBanners();
          _startTrackingUsersLocation();
        },
        child: const Text("RETRY"));
    context.showBanner(error, [button]);
    if (!hasLocationPermission) {
      context.showSnackBar(error, BarType.action,
          const SnackBarAction(label: "enable", onPressed: openAppSettings));
    }
  }

  Future<void> loadResources() async {
    _vehicleMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.vehicleMarkerImage,
    );
    final parkedLocation = widget.vehicle.parkedLocation!;
    final vehicleLatitude = parkedLocation['latitude'];
    final vehicleLongitude = parkedLocation['longitude'];
    vehicleLocation = LatLng(vehicleLatitude, vehicleLongitude);
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('destination'),
        icon: _vehicleMarker,
        position: vehicleLocation,
        infoWindow: const InfoWindow(title: 'Vehicle Location'),
      ));
    });
    return;
  }

  void _stopTrackingUsersLocation() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  void _startTrackingUsersLocation({
    bool showLoadingIndicator = true,
  }) async {
    showLoadingIndicator ? setState(() => isFetchingLocation = true) : null;

    _stopTrackingUsersLocation();
    if (await requestLocationPermission(context) && mounted) {
      _positionSubscription = context
          .read<LocationService>()
          .locationStream(distanceFilter: distanceFilter)
          .listen(
        (Position position) {
          userCurrentLocation = LatLng(position.latitude, position.longitude);
          if (userCurrentLocation != null) {
            log("POSITN TIN NERO POSIERNOER");

            print("new locaiton");
            setState(() {
              _updateCameraPosition(userCurrentLocation!);
              _getDirections(userCurrentLocation!, vehicleLocation);
            });
          }
        },
        onError: (dynamic error) {
          userCurrentLocation = null;
          distanceLeft = null;
          durationLeft = null;
          _showErrors(error.toString(), false);
        },
      );
    }
    showLoadingIndicator ? setState(() => isFetchingLocation = false) : null;
  }

  Future<void> _updateCameraPosition(LatLng userCurrentLocation) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition cameraPosition = CameraPosition(
      target: userCurrentLocation,
      zoom: 18,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  int _calculateInterval(double distance) {
    const double nearDistanceThreshold = 0.5;
    const double farDistanceThreshold = 100;

    if (distance <= nearDistanceThreshold) {
      return 0;
    } else {
      double scale = (distance - nearDistanceThreshold) /
          (farDistanceThreshold - nearDistanceThreshold);

      int dynamicInterval = (100 * scale).toInt();
      dynamicInterval = dynamicInterval.clamp(0, 100);

      return dynamicInterval;
    }
  }

  Future<void> _getDirections(
      LatLng userLocation, LatLng vehicleLocation) async {
    // _userLocationMarker = Marker(
    //   markerId: const MarkerId('origin'),
    //   position: userLocation,
    //   infoWindow: const InfoWindow(title: 'Your Location'),
    // );
    // _markers.add(_userLocationMarker!);

    [distanceLeft, durationLeft].any((element) => element == null)
        ? setState(() => isFetchingLocation = true)
        : null;

    if (mounted) {
      final response = await context
          .read<LocationService>()
          .getDirectionBetweenGeoLocations(
              originLatLng: userLocation, destinationLatLng: vehicleLocation);
      print(response.toString());
      if (response.error == null) {
        final distance = response.data!.distance;
        final duration = response.data!.duration;
        final steps = response.data!.steps;
        distanceLeft = distance;
        durationLeft = duration;

        _processDirectionsResponse(distance, duration, steps);
      } else {
        _showErrors(Strings.directionErrorText, true);
      }
    }

    isFetchingLocation ? setState(() => isFetchingLocation = false) : null;
  }

  void _processDirectionsResponse(
      String distance, String duration, List<dynamic> steps) {
    print(distance);
    double distanceValue = _parseDistance(distance);

    if (distanceValue <= AppConstants.distanceToUnlockVehicle) {
      _showBottomSheet();
      _stopTrackingUsersLocation();
      return;
    }
    List<LatLng> polylinePoints = _decodePolylinePoints(steps);

    setState(() {
      _polylines = {
        ..._polylines,
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylinePoints,
          endCap: Cap.roundCap,
          color: AppColors.rentalUsedColor,
          width: 13,
        )
      };
      distanceLeft = distance;
      durationLeft = duration;

      distanceFilter = _calculateInterval(distanceValue);
    });

    return;
  }

  // double _parseDistance(String distance) {
  //   double distanceValue = 0.0;
  //   if (distance.contains('km')) {
  //     distanceValue =
  //         double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  //     distanceValue *= 1000;
  //   } else if (distance.contains('m')) {
  //     distanceValue =
  //         double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  //   }
  //   return distanceValue;
  // }

  double _parseDistance(String distance) {
    double distanceValue = 0.0;

    if (distance.contains('km')) {
      distanceValue =
          double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

      distanceValue *= 3280.84;
    } else if (distance.contains('mi')) {
      distanceValue =
          double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

      distanceValue *= 5280;
    } else if (distance.contains('m')) {
      distanceValue =
          double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

      // Convert the distance value to feet (multiply by 3.28084, since 1 m = 3.28084 ft)
      distanceValue *= 3.28084;
    } else if (distance.contains('ft')) {
      distanceValue =
          double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    }

    print(distance);
    print(distanceValue);

    return distanceValue;
  }

  List<LatLng> _decodePolylinePoints(List<dynamic> steps) {
    List<LatLng> polylinePoints = [];
    for (var step in steps) {
      String points = step['polyline']['points'];
      List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);
      for (var point in decodedPoints) {
        polylinePoints.add(LatLng(point.latitude, point.longitude));
      }
    }
    return polylinePoints;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [_buildGoogleMap(size), _buildDistance()],
        ),
        if (isFetchingLocation) const Positioned.fill(child: LoadingOverlay()),
        _buildInfo(),
      ],
    );
  }

  Positioned _buildInfo() {
    return Positioned(
      top: 40,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(0.9)),
        child: IconButton(
          icon: const Icon(
            Icons.info_outline,
            size: 30,
          ),
          onPressed: () => const ProximityDialog().asDialog(context),
        ),
      ),
    );
  }

  DistanceContainerWidget _buildDistance() {
    return DistanceContainerWidget(
        distanceLeftString: distanceLeft ?? Strings.vehicleDistanceNotAvailable,
        durationLeftString:
            durationLeft ?? Strings.vehicleDistanceNotAvailable);
  }

  Widget _buildGoogleMap(Size size) {
    return Expanded(
      child: GoogleMap(
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        buildingsEnabled: false,
        trafficEnabled: false,
        mapToolbarEnabled: false,
        zoomControlsEnabled: true,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: const CameraPosition(
          target: AppConstants.defaultLocation,
          zoom: 16.0,
        ),
      ),
    );
  }

  void _showBottomSheet() {
    VehicleLocatedGetCode(
      rentalID: widget.rentalID,
      vehicle: widget.vehicle,
    ).asBottomSheet(
      context,
      invert: true,
      hapticType: HapticFeedbackType.vibrate,
      elevation: 0,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );
  }
}
