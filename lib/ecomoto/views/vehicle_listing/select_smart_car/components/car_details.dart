part of '../select_smart_car_view.dart';

class CarDetails extends StatefulWidget {
  final SmartCarVehicle vehicle;
  final void Function()? onTap;
  final bool isSelected;
  const CarDetails(
      {super.key, required this.vehicle, this.onTap, this.isSelected = false});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> with LocationMixin {
  String? vehicleLocation;
  @override
  void initState() {
    super.initState();
    getVehicleLocation(widget.vehicle.location);
  }

  void getVehicleLocation(LatLng vehicleGeoCode) async {
    final response = await context
        .read<LocationService>()
        .getPlaceNameFromCoordinates(
            vehicleGeoCode.longitude, vehicleGeoCode.latitude);
    if (mounted) {
      setState(() {
        vehicleLocation = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: !widget.isSelected
              ? Colors.transparent
              : context.colorScheme.secondary,
          border: Border.all(
              width: 1.5,
              color: !widget.isSelected
                  ? AppColors.lightGreyBorderColor
                  : AppColors.lightGreenBorderColor),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium)),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.smartCarCarIcon,
                scale: 1.5,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${widget.vehicle.make} ${widget.vehicle.model}",
                      style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: 'Year: ',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColors.darkGreyColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: widget.vehicle.year,
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: 'Charging Status: ',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColors.darkGreyColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '${widget.vehicle.battery.percentRemaining}% ',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Charged',
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    if (vehicleLocation == null)
                      const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator())
                    else
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: 'Location: ',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.darkGreyColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: vehicleLocation,
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ],
                      )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: 'VIN: ',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppColors.darkGreyColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: widget.vehicle.vin,
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(1),
                decoration: ShapeDecoration(
                  color: !widget.isSelected
                      ? Colors.transparent
                      : AppColors.checkBoxColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFCFD4DC)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Image.asset(
                  AppImages.checkIcon,
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
