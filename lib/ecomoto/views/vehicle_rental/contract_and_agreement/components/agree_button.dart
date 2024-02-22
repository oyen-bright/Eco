part of rental_agreement;

class RentalAgreeButton extends StatefulWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;

  final ScrollController scrollController;

  const RentalAgreeButton(
      {Key? key,
      required this.vehicle,
      required this.scrollController,
      required this.rentalData})
      : super(key: key);

  @override
  RentalAgreeButtonState createState() => RentalAgreeButtonState();
}

class RentalAgreeButtonState extends State<RentalAgreeButton> {
  bool selectValue = false;

  void onTermsAgreed() {
    if (widget.scrollController.offset <
        widget.scrollController.position.maxScrollExtent) {
      widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: 100.milliseconds,
          curve: Curves.easeInOut);
    } else {
      setState(() {
        selectValue = !selectValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: const EdgeInsets.only(
          left: AppConstants.viewPaddingHorizontal,
          right: AppConstants.viewPaddingHorizontal,
          top: AppSizes.size6,
          bottom: AppConstants.viewPaddingVertical),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCheckBox(context),
            const SizedBox(
              height: AppSizes.size6,
            ),
            _buildProceedButton()
          ],
        ),
      ),
    );
  }

  AppElevatedButton _buildProceedButton() {
    return AppElevatedButton(
      title: Strings.continueButtonText,
      onPressed: selectValue
          ? () {
              AppRouter.router.pushReplacement(
                  EcomotoRoutes.vehicleRentalPaymentsView,
                  extra: [widget.vehicle, widget.rentalData]);
            }
          : null,
    );
  }

  Row _buildCheckBox(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox.adaptive(
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColors.rentalDateViewColor,
            value: selectValue,
            onChanged: (value) {
              onTermsAgreed();
            }),
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: onTermsAgreed,
          child: Text(Strings.agreeTermsAnsConditionText,
              style: context.textTheme.titleSmall!.copyWith(
                color: AppColors.rentalDateViewColor,
              )),
        )
      ],
    );
  }
}
