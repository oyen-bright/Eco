part of locate_vehicle;

class VehicleLocatedBottomSheet extends StatefulWidget {
  final Vehicle vehicle;

  const VehicleLocatedBottomSheet({
    super.key,
    required this.vehicle,
  });

  @override
  State<VehicleLocatedBottomSheet> createState() =>
      VehicleLocatedBottomSheetState();
}

class VehicleLocatedBottomSheetState extends State<VehicleLocatedBottomSheet>
    with LocationMixin {
  String townString = '';
  String addressDescription = '';
  String distance = '';
  String? locationImage;

  Future<void> _fetchCurrentLocation() async {
    final parkedLocation = widget.vehicle.parkedLocation!;
    final vehicleLatitude = '${parkedLocation['latitude']}';
    final vehicleLongitude = '${parkedLocation['longitude']}';
    context.read<LocationService>().distanceBetweenGeoLocations(
        haversine: (use: false, convertToFeet: true),
        // haversine: (use: true, convertToFeet: true),
        destination: (long: vehicleLongitude, lat: vehicleLatitude),
        desiredAccuracy: LocationAccuracy.best).then((response) {
      if (response.error == null) {
        mounted
            ? setState(() {
                distance = response.data!.distance;
              })
            : null;
      }
    });
  }

  void _fetchPlacemark() async {
    final parkedLocation = widget.vehicle.parkedLocation!;
    final latitude = parkedLocation['latitude'];
    final longitude = parkedLocation['longitude'];
    context
        .read<LocationService>()
        .getPlaceMarkFromCoordinates(latitude, longitude)
        .then((response) {
      if (response.error == null) {
        List<Placemark> placemarks = response.data!;

        if (placemarks.isNotEmpty) {
          final placeDetails = formatPlaceWithTown(placemarks);
          if (mounted) {
            setState(() {
              townString = placeDetails.mainTown;
              addressDescription = placeDetails.fullAddress;
            });
            context
                .read<LocationService>()
                .getPlaceImage(locality: townString)
                .then((res) =>
                    mounted ? setState(() => locationImage = res) : null);
          }
        }
      } else {
        mounted ? context.showSnackBar(response.error) : null;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchCurrentLocation();
    _fetchPlacemark();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal,
          vertical: AppConstants.viewPaddingVertical),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.size10),
          _buildVehicleImage(context),
          const SizedBox(height: AppSizes.size10),
          _buildAddressAndDistanceDetails(context),
          const SizedBox(height: AppSizes.size10),
          _buildLocateButton(context),
        ],
      ),
    );
  }

  Widget _buildVehicleImage(BuildContext context) {
    return SizedBox(
      height: context.viewSize.height * .22,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: AppCachedImage(
            imageUrl: locationImage,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildAddressAndDistanceDetails(BuildContext context) {
    //TODO:reviews from vehicle rating
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSizes.size10),
        _addressRow(
            context: context,
            addressTitle: townString,
            streetString: addressDescription),
        const SizedBox(height: AppSizes.size20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: _containerBody(
                    context: context,
                    imageAsset: AppImages.locateVehicleIconImage,
                    text: Strings.vehicleDistancePrompt
                        .replaceAll('[distance]', distance))),
            const SizedBox(width: AppSizes.size20),
            Expanded(
              child: _containerBody(
                  context: context,
                  imageAsset: AppImages.locateRatingsImage,
                  text: '33 Reviews\n'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocateButton(BuildContext context) {
    return AppElevatedButton(
        onPressed: () => context.pop(), title: Strings.locateButtonText);
  }

  Widget _addressRow({
    required BuildContext context,
    required String addressTitle,
    required String streetString,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: _addressDescription(
            addressTitle: addressTitle,
            streetString: streetString,
            context: context,
          ),
        ),
        IconButton(
            onPressed: () {
              //TODO: save button on vehicle location
            },
            icon: const Icon(Icons.bookmark_border))
      ],
    );
  }

  Widget _addressDescription({
    required String addressTitle,
    required String streetString,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeText(
          addressTitle,
          style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.rentalUsedColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSizes.size4),
        AutoSizeText(
          streetString,
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.lowOpacityTextColor,
          ),
        ),
      ],
    );
  }

  Widget _containerBody({
    required BuildContext context,
    required String imageAsset,
    required String text,
  }) {
    return Container(
      padding: AppConstants.contentPadding,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(.1)),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageAsset),
          AutoSizeText(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.labelMedium!.copyWith(),
          ),
        ],
      ),
    );
  }
}
