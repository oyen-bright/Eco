part of vehicle_search_map;

class SearchGoogleMapsView extends StatefulWidget {
  const SearchGoogleMapsView({
    super.key,
  });

  @override
  State<SearchGoogleMapsView> createState() => SearchGoogleMapsViewState();
}

class SearchGoogleMapsViewState extends State<SearchGoogleMapsView>
    with LocationMixin {
  late final Completer<GoogleMapController> _mapController = Completer();

  final CustomInfoWindowController _infoWindowController =
      CustomInfoWindowController();
  final LatLng _center = AppConstants.defaultLocation;
  final TextEditingController _searchPlacesController = TextEditingController();
  final Set<Marker> _markers = {};

  List<Marker> _vehicleMarkers = [];
  List<Vehicle> vehicles = [];
  LatLng? usersLocation;
  bool isFetchingLocation = false;

  @override
  void initState() {
    super.initState();
    _addVehiclesToMap();
  }

  void _showError(String error) {
    if (mounted) {
      context.showSnackBar(error);
    }
  }

  Future<LatLng?> _getUsersLocation() async {
    final response = await context.read<LocationService>().getCurrentLocation();
    if (mounted) {
      if (response.error != null) {
        if (response.hasPermission ?? false) {
          context.showSnackBar(response.error);
          return null;
        }
        requestLocationPermission(context);
      }
      return usersLocation = response.position != null
          ? LatLng(response.position!.latitude, response.position!.longitude)
          : null;
    }
    return null;
  }

  Future<void> _addVehiclesToMap() async {
    final response = await _getUsersLocation();
    if (mounted) {
      final usersLocation = response;
      final listedVehicle = context.read<VehicleCubit>().state.maybeMap(
            loaded: (loadedState) => loadedState.vehicles,
            orElse: () => [],
          ) as List<Vehicle>;

      print(listedVehicle.length);

      final List<Vehicle> loadedVehicles = listedVehicle;
      final List<Marker> vehicleMarkers =
          await _buildMarkers(loadedVehicles, usersLocation);

      setState(() {
        vehicles = listedVehicle;
        _vehicleMarkers = vehicleMarkers;
        _markers.addAll(_vehicleMarkers);
      });
    }
  }

  Future<List<Marker>> _buildMarkers(
      List<Vehicle> vehicles, LatLng? usersLocation) async {
    final customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.vehicleMarkerImage,
    );

    return vehicles
        .where((vehicle) => vehicle.parkedLocation != null)
        .map((vehicle) {
      final parkedLocation = vehicle.parkedLocation!;
      final latitude = parkedLocation['latitude'];
      final longitude = parkedLocation['longitude'];

      final vehicleParkedLocation = vehicle.parkedLocation;
      return Marker(
        markerId: MarkerId(vehicle.id.toString()),
        position: LatLng(latitude, longitude),
        icon: customMarker,
        onTap: () {
          _infoWindowController.addInfoWindow!(
            CustomInfoWindowForMap(
                vehicleImage: vehicle.carImages.isNotEmpty
                    ? vehicle.carImages.first['imageUrl']
                    : null,
                getLocation: (
                  long: vehicleParkedLocation?['longitude'],
                  lat: vehicleParkedLocation?['latitude'],
                ),
                mileage: vehicle.millagePerCharge,
                makeString: vehicle.make,
                onBrowseTap: () => AppRouter.router
                    .push(EcomotoRoutes.vehicleRental, extra: vehicle)),
            LatLng(latitude ?? 0.0, longitude ?? 0.0),
          );
        },
      );
    }).toList();
  }

  Future<void> _navigateToInputtedAddress(String placeId) async {
    context.removeFocus;
    mounted ? setState(() => isFetchingLocation = true) : null;

    final details = await context.read<LocationService>().placeDetails(placeId);

    if (details.error != null) {
      _showError(details.error!);
      mounted ? setState(() => isFetchingLocation = false) : null;

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
        _showError(response.error!);
        mounted ? setState(() => isFetchingLocation = false) : null;

        return;
      }

      _searchPlacesController.text = formatPlace(response.data!);
      final GoogleMapController controller = await _mapController.future;
      CameraPosition kGooglePlex = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 19,
      );

      controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
    }
    mounted ? setState(() => isFetchingLocation = false) : null;
  }

  @override
  void dispose() {
    super.dispose();
    _searchPlacesController.dispose();
    _infoWindowController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _buildGoogleMap(context.viewSize),
        _buildVehicleMakerDetails(),
        if (isFetchingLocation) _buildLoadingOverlay(),
        _buildSearchBar(context),
      ],
    );
  }

  SizedBox _buildGoogleMap(Size size) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: GoogleMap(
        // compassEnabled: false,
        mapToolbarEnabled: false,
        fortyFiveDegreeImageryEnabled: true,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            top: MediaQuery.of(context).padding.top + 60),
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          _infoWindowController.googleMapController = controller;
          _mapController.complete(controller);
        },
        onTap: (position) {
          _infoWindowController.hideInfoWindow!();
        },
        onCameraMove: (position) {
          _infoWindowController.onCameraMove!();
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          tilt: 90,
          zoom: 19.0,
        ),
      ),
    );
  }

  CustomInfoWindow _buildVehicleMakerDetails() {
    return CustomInfoWindow(
      controller: _infoWindowController,
      height: 200,
      width: 183,
      offset: 55,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Positioned(
        top: 14,
        left: 0,
        right: 0,
        child: AutoCompleteSearchBar(
          searchPlacesController: _searchPlacesController,
          onPlaceSelected: (placeId) => _navigateToInputtedAddress(placeId),
        ));
  }

  Center _buildLoadingOverlay() {
    return const Center(
        child: LoadingOverlay(
      blur: (sigmaX: 3, sigmaY: 3),
    ));
  }
}

class AutoCompleteSearchBar extends StatefulWidget {
  final TextEditingController searchPlacesController;
  final void Function(String) onPlaceSelected;
  const AutoCompleteSearchBar(
      {super.key,
      required this.searchPlacesController,
      required this.onPlaceSelected});

  @override
  State<AutoCompleteSearchBar> createState() => _AutoCompleteSearchBarState();
}

class _AutoCompleteSearchBarState extends State<AutoCompleteSearchBar> {
  final FocusNode _searchFocusNode = FocusNode();

  bool _isSearching = false;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && !_isSearching) {
        setState(() => _isSearching = _searchFocusNode.hasFocus);
      }
    });
  }

  Future<void> _loadAutoComplete(String value) async {
    final result =
        await context.read<LocationService>().fetchPlaceList(placeId: value);
    setState(() {
      _placeList = result.predictions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            // height: kToolbarHeight,
            child: TextSearchBar(
          focusNode: _searchFocusNode,
          elevation: 5,
          onChanged: (value) {
            _loadAutoComplete(value);
          },
          controller: widget.searchPlacesController,
          textCapitalization: TextCapitalization.words,
          hint: Strings.searchBarHintText,
          showBackButton: true,
          hasFilter: false,
        )),
        if (_isSearching && _placeList.isNotEmpty)
          Material(
            color: Colors.transparent,
            elevation: 30,
            child: ClipRect(
              clipBehavior: Clip.antiAlias,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingHorizontal,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _placeList.length,
                  itemBuilder: (context, index) {
                    final place = _placeList[index];
                    return ListTile(
                      title: Text(place['description']),
                      onTap: () {
                        final selectedPlaceId = place['place_id'];
                        widget.onPlaceSelected(selectedPlaceId);
                        _isSearching = false;
                      },
                    );
                  },
                ),
              ),
            ),
          )
      ],
    );
  }
}
