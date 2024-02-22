part of '../showcase_vehicle_view.dart';

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.showcaseYourVehicleText,
          style: AppTextStyles.listingFormHeaderTextStyle,
          textAlign: TextAlign.left,
        ),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: context.textTheme.bodySmall,
            children: [
              const TextSpan(
                text: Strings.addAttractivePhotosText,
              ),
              TextSpan(
                text: Strings.addAttractivePhotosText2,
                style: context.textTheme.bodySmall
                    ?.copyWith(color: context.colorScheme.primary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
