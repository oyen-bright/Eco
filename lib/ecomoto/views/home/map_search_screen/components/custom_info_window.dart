part of vehicle_search_map;

class CustomInfoWindowForMap extends StatelessWidget {
  final int mileage;
  final ({double? lat, double? long}) getLocation;
  final String makeString;
  final String? vehicleImage;

  final void Function() onBrowseTap;

  const CustomInfoWindowForMap({
    Key? key,
    required this.mileage,
    required this.makeString,
    required this.onBrowseTap,
    required this.getLocation,
    required this.vehicleImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: CustomPaint(
        painter: SpeechBubblePainter(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: const BoxDecoration(
              // color: context.colorScheme.background,
              // borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildVehicleImage(),
              _buildVehicleInfo(context),
              _buildViewVehicleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewVehicleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: AppElevatedButton.small(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius - 5),
        padding: EdgeInsets.zero,
        title: Strings.vehicleMarkerButton,
        onPressed: onBrowseTap,
      ),
    );
  }

  Padding _buildVehicleInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 2,
          ),
          AutoSizeText(
            makeString,
            maxLines: 1,
            style: context.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          vehicleRatings(context),
          const SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: mileageRow(context)),
              Expanded(
                child: VehicleLocationRow(
                  geoLocation: getLocation,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }

  Expanded _buildVehicleImage() {
    return Expanded(
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.borderRadius),
                topRight: Radius.circular(AppConstants.borderRadius)),
            child: (vehicleImage == null
                ? Image.asset(AppImages.noVehicleImage)
                : AppCachedImage(
                    fit: BoxFit.cover,
                    imageUrl: vehicleImage,
                    withPinata: true,
                  ))));
  }

  Widget vehicleRatings(BuildContext context) {
    return const RentalRating(
      iconSize: 15,
      fontSize: 11,
      ratingCount: 30,
    );
  }

  Widget mileageRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.speed_outlined,
          size: 15,
          color: AppColors.primaryLight,
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: AutoSizeText(
              Strings.maxMilage.replaceAll('[mileage]', mileage.toString()),
              // maxLines: 1,
              minFontSize: 11,
              maxFontSize: 13,
              style: context.textTheme.labelSmall!.copyWith(
                  letterSpacing: -0.3,
                  color: AppColors.primaryLight,
                  height: 1.2)),
        ),
      ],
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const tailHeight = 15.0;
    const tailWidth = 10.0;

    final path = Path()
      ..moveTo(size.width / 2 - tailWidth / 2, size.height - tailHeight)
      ..lineTo(size.width / 2 + tailWidth / 2, size.height - tailHeight)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        0,
        0,
        size.width,
        size.height - tailHeight,
        bottomLeft: const Radius.circular(AppConstants.borderRadius),
        bottomRight: const Radius.circular(AppConstants.borderRadius),
        topLeft: const Radius.circular(AppConstants.borderRadius),
        topRight: const Radius.circular(AppConstants.borderRadius),
      ),
      paint,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class VehicleLocationRow extends StatefulWidget {
  final ({double? long, double? lat}) geoLocation;

  const VehicleLocationRow({super.key, required this.geoLocation});

  @override
  State<VehicleLocationRow> createState() => VehicleLocationRowState();
}

class VehicleLocationRowState extends State<VehicleLocationRow> {
  bool isLoading = false;

  String locationText = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    if (widget.geoLocation.lat != null && widget.geoLocation.long != null) {
      final response = await context
          .read<LocationService>()
          .distanceBetweenGeoLocations(destination: (
        long: widget.geoLocation.long!.toString(),
        lat: widget.geoLocation.lat!.toString()
      ));
      if (mounted) {
        setState(() {
          isLoading = false;
          if (response.error != null) {
            locationText = response.error!;
          } else {
            locationText = "${response.data?.distance}";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const icon = Icon(
      Icons.location_on_outlined,
      color: AppColors.primaryLight,
      size: 15,
    );
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: AutoSizeText(
            locationText,
            minFontSize: 11,
            maxFontSize: 13,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.textTheme.labelSmall!.copyWith(
              letterSpacing: -0.3,
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );

    return isLoading
        ? AppShimmer(
            enabled: isLoading,
            child: row,
          )
        : row;
  }
}
