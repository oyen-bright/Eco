part of vehicle_details;

class VehicleDetails extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetails({super.key, required this.vehicle});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildName(context),
        const SizedBox(
          height: AppSizes.size2,
        ),
        _buildRating(context),
        const SizedBox(
          height: AppSizes.size16,
        ),
        _buildFeatures(context),
      ],
    );
  }

  SizedBox _buildName(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    vehicle.make,
                    style: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                VehicleLocation(geoLocation: (
                  long: vehicle.parkedLocation?['longitude'],
                  lat: vehicle.parkedLocation?['latitude']
                )),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                // setState(() {
                //   if (isSaved) {
                //     savedVehicles.remove(widget.vehicle);
                //     context.showSnackBar('Vehicle removed from saved list');
                //   } else {
                //     savedVehicles.add(widget.vehicle);
                //     context.showSnackBar('Vehicle added to saved list');
                //   }
                //   isSaved = !isSaved;
                // });
              },
              icon: Icon(
                Icons.favorite_border,
                color: context.colorScheme.primary,
              )),
        ],
      ),
    );
  }

  SizedBox _buildRating(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const StarRating(
            currentRating: 4,
            size: 22,
          ),
          const SizedBox(
            width: AppSizes.size4,
          ),
          Expanded(
              child: AutoSizeText(
            "440+ Reviewer",
            style: context.textTheme.labelSmall!.copyWith(
              letterSpacing: -0.1,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight,
            ),
          ))
        ],
      ),
    );
  }

  SizedBox _buildFeatures(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeText(
            Strings.featuresHeading.toUpperCase(),
            style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.primaryLight),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              (title: Strings.modelTitleText, subtitle: vehicle.model),
              (title: Strings.colorTitleText, subtitle: vehicle.color),
              (title: Strings.capacityTitleText, subtitle: vehicle.capacity)
            ].map((e) => _descriptionItem(e)).toList(),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              (
                title: Strings.plateNumberTitleText,
                subtitle: vehicle.plateNumber ?? "N/A"
              ),
              (
                title: Strings.mileagePerChargeTitleText,
                subtitle: vehicle.millagePerCharge
              ),
              (title: Strings.lastMaintenanceText, subtitle: "N/A")
            ].map((e) => _descriptionItem(e)).toList(),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
        ],
      ),
    );
  }

  Expanded _descriptionItem(({Object subtitle, String title}) e) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            e.title,
            maxLines: 1,
            style: const TextStyle(fontSize: 13, color: AppColors.primaryLight),
          ),
          AutoSizeText(
            '${e.subtitle}',
            maxLines: 1,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark),
          )
        ],
      ),
    );
  }
}
