part of '../vehicle_onboarding_view.dart';

class OnboardingImageHeader extends StatelessWidget {
  const OnboardingImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Image.asset(AppImages.smartCarOnboardingImage));
  }
}
