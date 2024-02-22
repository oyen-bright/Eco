part of '../listing_location_view.dart';

class LocationPicker extends StatefulWidget {
  final VehicleModel vehicleInputData;

  const LocationPicker({
    Key? key,
    required this.vehicleInputData,
  }) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> with LocationMixin {
  final TextEditingController _searchPlacesController = TextEditingController();
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng _center = AppConstants.defaultLocation;
  final Set<Marker> _markers = {};
  final FocusNode _searchFocusNode = FocusNode();

  bool _isSearching = false;
  bool _isFetchingLocation = false;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();

    final currentVehicleLocation =
        widget.vehicleInputData.smartCarVehicle?.location;
    _center = widget.vehicleInputData.smartCarVehicle?.location ??
        AppConstants.defaultLocation;
    widget.vehicleInputData.latitude = currentVehicleLocation?.latitude;
    widget.vehicleInputData.longitude = currentVehicleLocation?.longitude;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentVehicleLocation != null
          ? _fetchPlacemark(currentVehicleLocation)
          : null;
    });

    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchPlacesController.dispose();
    super.dispose();
  }

  Future<void> _onSearchChanged(String value) async {
    final result =
        await context.read<LocationService>().fetchPlaceList(placeId: value);
    setState(() {
      _placeList = result.predictions;
    });
  }

  Future<void> _fetchSelectedPlaceCoordinates(String placeId) async {
    context.removeFocus;
    mounted ? setState(() => _isFetchingLocation = true) : null;

    final details = await context.read<LocationService>().placeDetails(placeId);
    if (details.error != null) {
      _showError();
      mounted ? setState(() => _isFetchingLocation = false) : null;
      return;
    }

    final geometry = details.data!['result']['geometry'];
    final location = geometry['location'];

    final double latitude = location['lat'];
    final double longitude = location['lng'];

    if (mounted) {
      final response = await context
          .read<LocationService>()
          .getPlaceMarkFromCoordinates(latitude, longitude);
      if (response.error != null) {
        _showError();
        mounted ? setState(() => _isFetchingLocation = false) : null;
        return;
      }

      widget.vehicleInputData.latitude = latitude;
      widget.vehicleInputData.longitude = longitude;

      // widget.onLocationSelected(latitude, longitude);
      _searchPlacesController.text = formatPlace(response.data!);

      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );

      final GoogleMapController controller = await _mapController.future;
      CameraPosition kGooglePlex = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 18,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
      mounted ? setState(() => _isFetchingLocation = false) : null;
    }
  }

  Future<void> _fetchCurrentLocation() async {
    mounted ? setState(() => _isFetchingLocation = true) : null;

    final response = await context
        .read<LocationService>()
        .getCurrentLocation(LocationAccuracy.best);
    if (response.error == null && response.position != null) {
      _fetchPlacemark(
          LatLng(response.position!.latitude, response.position!.longitude));
    } else {
      if (mounted) {
        requestLocationPermission(context);
      }
    }
    mounted ? setState(() => _isFetchingLocation = false) : null;
  }

  Future<void> _fetchPlacemark(LatLng tappedPoint) async {
    context.removeFocus;
    mounted ? setState(() => _isFetchingLocation = true) : null;

    final response =
        await context.read<LocationService>().getPlaceMarkFromCoordinates(
              tappedPoint.latitude,
              tappedPoint.longitude,
            );
    if (response.error != null) {
      _showError(response.error!);
      mounted ? setState(() => _isFetchingLocation = false) : null;
      return;
    }
    widget.vehicleInputData.latitude = tappedPoint.latitude;
    widget.vehicleInputData.longitude = tappedPoint.longitude;

    // widget.onLocationSelected(tappedPoint.latitude, tappedPoint.longitude);
    _searchPlacesController.text = formatPlace(response.data!);

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: tappedPoint,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
        infoWindow: const InfoWindow(title: Strings.markerInfo),
      ),
    );
    final GoogleMapController controller = await _mapController.future;
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(tappedPoint.latitude, tappedPoint.longitude),
      zoom: 18,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
    mounted ? setState(() => _isFetchingLocation = false) : null;
  }

  void _showError([String? error]) {
    final errorMessage = error ?? Strings.errorFetchingLocation;
    mounted ? context.showSnackBar(errorMessage) : null;
  }

  Widget _buildSearchAddress(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: AppSizes.size10),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: _searchFocusNode.hasFocus
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: AppSizes.size4,
                    blurRadius: AppSizes.size8,
                    offset: const Offset(0, AppSizes.size4),
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(AppSizes.size6),
          border: Border.all(
            color: context.colorScheme.primary,
          ),
          color: context.colorScheme.onPrimary,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextFormField(
              focusNode: _searchFocusNode,
              onChanged: _onSearchChanged,
              controller: _searchPlacesController,
              textAlign: TextAlign.start,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: Strings.searchLocationText,
              ),
            )),
            IconButton(
                onPressed: () {
                  context.removeFocus;
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ));
  }

  Widget _buildMapView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.size2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.size6),
        border: Border.all(
          color: context.colorScheme.primary,
        ),
      ),
      height: AppSizes.size300 + AppSizes.size20,
      width: double.infinity,
      child: GoogleMap(
        compassEnabled: false,
        mapToolbarEnabled: false,
        trafficEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        markers: _markers,
        mapType: MapType.normal,
        onTap: _fetchPlacemark,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
      ),
    );
  }

  Widget _buildPlaceList(BuildContext context) {
    return Positioned.fill(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.size8),
          color: Colors.white,
          border: Border.all(
            color: context.colorScheme.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: AppSizes.size4,
              blurRadius: AppSizes.size8,
              offset: const Offset(0, AppSizes.size4),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _placeList.length,
          itemBuilder: (context, index) {
            final place = _placeList[index];
            return ListTile(
              title: Text(place['description']),
              onTap: () {
                final selectedPlaceId = place['place_id'];
                _fetchSelectedPlaceCoordinates(selectedPlaceId);
                setState(() => _isSearching = false);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Positioned(
      right: 13,
      bottom: 13,
      child: FloatingActionButton(
        backgroundColor: context.colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: _fetchCurrentLocation,
        child: const Icon(Icons.my_location_rounded),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSearchAddress(context),
        const SizedBox(height: AppSizes.size10),
        Stack(
          alignment: Alignment.center,
          children: [
            _buildMapView(context),
            if (_isFetchingLocation)
              const Positioned.fill(
                  child: Padding(
                      padding: EdgeInsets.all(5), child: LoadingOverlay())),
            _buildFloatingActionButton(context),
            if (_isSearching && _placeList.isNotEmpty) _buildPlaceList(context),
          ],
        ),
      ],
    );
  }
}
