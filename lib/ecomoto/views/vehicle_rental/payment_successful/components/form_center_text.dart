part of rental_payment_successful;

class FormCenterText extends StatelessWidget {
  final String amountPaid;
  const FormCenterText({
    Key? key,
    required this.amountPaid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: AppSizes.size16,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.lightGreyColor.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(AppConstants.borderRadiusMedium)),
          child: Text('${AppConstants.appCurrency} $amountPaid',
              style: context.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary)),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        Text(
          Strings.paymentSuccessText,
          style: context.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        Text(
          Strings.transfersAreReviewedText,
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall!
              .copyWith(color: AppColors.lowOpacityTextColor),
        )
      ],
    );
  }
}
