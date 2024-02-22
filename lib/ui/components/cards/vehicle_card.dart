import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/widgets/carosel.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';

import 'vehicle_location.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final void Function(Vehicle)? onPressed;
  final bool isSaved;

  const VehicleCard._internal({
    Key? key,
    required this.vehicle,
    this.isSaved = false,
    required this.onPressed,
  }) : super(key: key);

  factory VehicleCard({
    Key? key,
    required Vehicle vehicle,
    bool isSaved = false,
    void Function(Vehicle)? onPressed,
  }) {
    return VehicleCard._internal(
      key: key,
      vehicle: vehicle,
      isSaved: isSaved,
      onPressed: onPressed,
    );
  }

  factory VehicleCard.saved({
    Key? key,
    required Vehicle vehicle,
    void Function(Vehicle)? onPressed,
  }) {
    return VehicleCard._internal(
      key: key,
      vehicle: vehicle,
      isSaved: true,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isSaved
        ? _buildSavedVehicleCard(context)
        : _buildRegularVehicleCard(context);
  }

  static Widget get shimmer {
    return AppShimmer(
      child: VehicleCard(
        vehicle: Vehicle.dummy(),
        onPressed: null,
      ),
    );
  }

  Widget _buildSavedVehicleCard(BuildContext context) {
    return GestureDetector(
      onTap: onPressed != null ? () => onPressed!(vehicle) : null,
      child: SizedBox(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVehicleImage(),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                _infoRow(context, vehicle, isSaved),
              ],
            ),
            _buildSavedIcon(context),
          ],
        ),
      ),
    );
  }

  Positioned _buildSavedIcon(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () {
          // savedVehicles.remove(vehicle);
          context.showSnackBar(
            'Vehicle removed from saved',
            BarType.action,
            SnackBarAction(
              label: "Undo",
              onPressed: () {
                // savedVehicles.add(vehicle);
              },
            ),
          );
        },
        icon: CircleAvatar(
          radius: 15,
          backgroundColor: context.colorScheme.onPrimary.withOpacity(0.9),
          child: Icon(
            Icons.favorite,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildRegularVehicleCard(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildVehicleImage(),
          const SizedBox(
            height: AppSizes.size10,
          ),
          _infoRow(context, vehicle, isSaved),
          AppElevatedButton.small(
            onPressed: onPressed != null ? () => onPressed!(vehicle) : null,
            title: 'Rent Now',
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, Vehicle vehicle, bool isSaved) {
    final vehicleParkedLocation = vehicle.parkedLocation;
    return isSaved
        ? _savedInfo(context, vehicle, vehicleParkedLocation)
        : _regularInfo(vehicle, context, vehicleParkedLocation);
  }

  Column _regularInfo(Vehicle vehicle, BuildContext context,
      Map<String, dynamic>? vehicleParkedLocation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                vehicle.make,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${vehicle.pricePerHour}',
                      style: context.textTheme.titleSmall!.copyWith(
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' /day',
                      style: context.textTheme.labelSmall!.copyWith(
                        letterSpacing: -0.3,
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _vehicleRatings(context),
            _buildVehicleLocation(vehicleParkedLocation, true)
          ],
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
      ],
    );
  }

  Column _savedInfo(BuildContext context, Vehicle vehicle,
      Map<String, dynamic>? vehicleParkedLocation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _vehicleRatings(context),
          ],
        ),
        AutoSizeText(
          vehicle.make,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyLarge!.copyWith(
            color: context.colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGasFill(context),
            _buildVehicleLocation(vehicleParkedLocation, false),
          ],
        ),
        const SizedBox(
          height: AppSizes.size2,
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$${vehicle.pricePerHour}',
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' /day',
                  style: context.textTheme.labelSmall!.copyWith(
                      letterSpacing: -0.3,
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Expanded _buildVehicleImage() {
    return Expanded(
      child: SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.borderRadius),
            topRight: Radius.circular(AppConstants.borderRadius),
          ),
          child: (vehicle.carImages.isNotEmpty)
              ? AppCarousel.forPinataImages(
                  autoPlay: false,
                  items: vehicle.carImages,
                )
              : Image.asset(
                  AppImages.noVehicleImage,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  VehicleLocation _buildVehicleLocation(
      Map<String, dynamic>? vehicleParkedLocation, bool withBorder) {
    return VehicleLocation(
      withBorder: withBorder,
      geoLocation: (
        long: vehicleParkedLocation?['longitude'],
        lat: vehicleParkedLocation?['latitude'],
      ),
    );
  }

  Widget _buildGasFill(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          AppImages.gasIcon,
          height: 16,
          width: 16,
        ),
        Expanded(
          child: AutoSizeText('24% Filled',
              maxLines: 1,
              style: context.textTheme.labelSmall!.copyWith(
                  fontSize: AppSizes.size10,
                  letterSpacing: -0.3,
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    ));
  }

  Expanded _vehicleRatings(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.ratingsIcon,
            height: 14,
            width: 14,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '5.0',
                    style: context.textTheme.labelLarge!.copyWith(
                      color: const Color(0xFFFFCD1A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' (134)',
                    style: context.textTheme.labelSmall!.copyWith(
                        letterSpacing: -0.3,
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
