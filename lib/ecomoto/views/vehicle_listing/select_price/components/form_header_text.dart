part of '../select_price_view.dart';

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Strings.selectPriceHeaderText,
          style: AppTextStyles.listingFormHeaderTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          Strings.tipText,
          style:
              AppTextStyles.listingFormHeaderTextStyle.copyWith(fontSize: 17),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
