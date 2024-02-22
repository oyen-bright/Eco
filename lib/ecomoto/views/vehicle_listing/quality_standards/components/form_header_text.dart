part of '../quality_standards_view.dart';

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Text(
        Strings.qualityStandardsHeadingText,
        style: AppTextStyles.listingFormHeaderTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
