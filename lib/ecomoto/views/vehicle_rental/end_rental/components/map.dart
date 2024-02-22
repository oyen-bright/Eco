part of '../end_rental.dart';

class LocateVehicleMap extends StatefulWidget {
  final Trip trip;
  const LocateVehicleMap({Key? key, required this.trip}) : super(key: key);

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
  late final LatLng vehicleLocation;
  Set<Circle>? _parkingCircleRadius;

  StreamSubscription<Position>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadResources().then((_) {
        _startTrackingUsersLocation();
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
    final parkedLocation = widget.trip.carDetails.parkedLocation!;
    final vehicleLatitude = parkedLocation['latitude'];
    final vehicleLongitude = parkedLocation['longitude'];

    // vehicleLocation = LatLng(vehicleLatitude, vehicleLongitude);
    vehicleLocation = LatLng(40.712914, -74.008713);

    setState(() {
      _parkingCircleRadius = {
        Circle(
            consumeTapEvents: true,
            fillColor: context.colorScheme.primary.withOpacity(0.2),
            strokeWidth: 2,
            onTap: () => const ProximityDialog().asDialog(context),
            strokeColor: context.colorScheme.primary,
            circleId: const CircleId("parking location"),
            center: vehicleLocation,
            radius: AppConstants.endTripParkingLocationRadius)
      };
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
    double distanceValue = parseDistance(distance);

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
      child: AppMap(
        circles: _parkingCircleRadius,
        markers: _markers,
        polylines: _polylines,
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
    // VehicleLocatedGetCode(
    //   vehicle: widget.trip,
    // ).asBottomSheet(
    //   context,
    //   invert: true,
    //   hapticType: HapticFeedbackType.vibrate,
    //   elevation: 0,
    //   isDismissible: true,
    //   enableDrag: false,
    //   backgroundColor: Colors.transparent,
    // );
  }
}
