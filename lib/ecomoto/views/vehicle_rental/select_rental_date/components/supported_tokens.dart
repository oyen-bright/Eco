part of rental_date;

class RentalSupportedToken extends StatelessWidget {
  const RentalSupportedToken({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            Strings.ourSupportedTokensText,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.size10),
          _buildTokenRow(context),
        ],
      ),
    );
  }

  Widget _buildTokenRow(BuildContext context) {
    List<Map<String, String>> tokens = [
      {Strings.tetherText: AppImages.tetherImage},
      {Strings.usdCoinText: AppImages.usdCoinImage},
      {Strings.daiText: AppImages.daiImage},
      {Strings.binanceText: AppImages.binanceImage},
      {Strings.trueUsdText: AppImages.trueUsdImage},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: tokens
          .map((token) => _buildFeatureColumn(
                context: context,
                label: token.keys.first,
                imagePath: token.values.first,
              ))
          .toList(),
    );
  }

  Widget _buildFeatureColumn({
    required BuildContext context,
    required String label,
    required String imagePath,
  }) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: size.width * .10,
            width: size.width * .10,
          ),
          Text(
            label,
            style: context.textTheme.titleSmall!
                .copyWith(color: AppColors.rentalDateViewColor),
          ),
        ],
      ),
    );
  }
}
