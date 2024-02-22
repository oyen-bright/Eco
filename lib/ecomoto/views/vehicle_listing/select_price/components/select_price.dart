part of '../select_price_view.dart';

class SelectVehiclePrice extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const SelectVehiclePrice({
    super.key,
    required this.vehicleInputData,
  });
  static int minimumPrice = AppConstants.vehicleListingDefaultMinimumPrice;
  static int maximumPrice = AppConstants.vehicleListingDefaultMaximumPrice;

  @override
  Widget build(BuildContext context) {
    void onProceed() {
      if (minimumPrice < 1 || maximumPrice < 1) {
        context.showSnackBar(Strings.invalidPriceZero);
        return;
      }

      if (minimumPrice > maximumPrice) {
        context.showSnackBar(Strings.invalidPriceRange);
        return;
      }

      vehicleInputData.minimumPrice = minimumPrice;
      vehicleInputData.maximumPrice = maximumPrice;

      AppRouter.router
          .push(EcomotoRoutes.vehicleListingLocation, extra: vehicleInputData);

      debugPrint('Vehicle Input Data: ${vehicleInputData.toString()}');
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildMinimumPriceSetter(context),
                const SizedBox(
                  height: AppSizes.size20,
                ),
                _buildMaximumPriceSetter(
                  context,
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppElevatedButtonWithIcon(
                onPressed: () => context.pop(),
                navigateBackward: true,
              ),
            ),
            const SizedBox(
              width: AppSizes.size10,
            ),
            Expanded(
              child: AppElevatedButtonWithIcon(
                onPressed: onProceed,
                navigateForward: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildMinimumPriceSetter(
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.lightPurpleSecondary,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    Strings.minimumLabel,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const AutoSizeText(Strings.minimumPriceDescription)
            ],
          ),
        ),
        PriceSelector(
          initialPrice: minimumPrice,
          onChanged: (int newPrice) {
            minimumPrice = newPrice;
          },
        )
      ],
    );
  }

  Row _buildMaximumPriceSetter(
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.lightPurple,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    Strings.maximumLabel,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const AutoSizeText(Strings.maximumPriceDescription)
            ],
          ),
        ),
        PriceSelector(
          initialPrice: maximumPrice,
          onChanged: (int newPrice) {
            maximumPrice = newPrice;
          },
        )
      ],
    );
  }
}
