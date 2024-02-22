part of '../extra_features_view.dart';

class ExtraFeaturesHeaderText extends StatelessWidget {
  const ExtraFeaturesHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Text(
        Strings.addExtraFeaturesText,
        style: AppTextStyles.listingFormHeaderTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
