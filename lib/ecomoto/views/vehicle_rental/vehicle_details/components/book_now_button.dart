part of vehicle_details;

class BookVehicleButton extends StatelessWidget {
  final Vehicle vehicle;
  const BookVehicleButton({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildPrice(context), _buildBookNowButton()],
          ),
        ),
      ),
    );
  }

  AppElevatedButton _buildBookNowButton() {
    return AppElevatedButton.small(
        elevation: 0,
        borderRadius: BorderRadius.circular(5),
        fontSize: 13,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        onPressed: () {
          AppRouter.router
              .push(EcomotoRoutes.vehicleRentalDatePicker, extra: vehicle);
        },
        title: Strings.bookNowText);
  }

  Column _buildPrice(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${AppConstants.appCurrency}${vehicle.pricePerHour}',
                  style: context.textTheme.titleLarge!.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' /day',
                  style: context.textTheme.titleSmall!.copyWith(
                      letterSpacing: -0.3,
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Text(
          '${AppConstants.appCurrency}${calculatePricePerHour(vehicle.pricePerHour)} /hour',
          style: context.textTheme.labelMedium!.copyWith(
              letterSpacing: -0.3,
              color: AppColors.primaryLight,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
