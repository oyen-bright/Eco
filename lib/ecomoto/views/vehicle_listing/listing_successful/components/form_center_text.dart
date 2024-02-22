part of '../listing_successful_view.dart';

class FormCenterText extends StatelessWidget {
  const FormCenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.carListedSuccessfully,
          style: AppTextStyles.listingFormHeaderTextStyle.copyWith(
              color: const Color(0xFF1D3A70), fontSize: AppSizes.size26),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          width: AppSizes.size300 + AppSizes.size30,
          child: Text(
            Strings.carListedBodyText,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
