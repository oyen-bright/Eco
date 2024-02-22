part of on_boarding;

@immutable
class Constants {
  const Constants._();

  static const Size dotIndicatorSize = Size(AppSizes.size18, AppSizes.size6);

  static const List<String> onBoardingImages = [
    AppImages.onboardingImage1,
    AppImages.onboardingImage2,
    AppImages.onboardingImage3,
  ];

  static const List onBoardingPrompts = [
    {'title': Strings.safeTitle, 'subtitle': Strings.safeSubtitle},
    {'title': Strings.secureTitle, 'subtitle': Strings.secureSubtitle},
    {'title': Strings.swiftTitle, 'subtitle': Strings.swiftSubtitle},
  ];

  static const double dotIndicatorBorderRadius = 4;

  static const Size onBoardingButtonMinimumSize =
      Size(AppSizes.size100, AppSizes.size45);

  static const double onBoardingButtonBorderRadius = AppSizes.size10;
  static const double onBoardingTextContainerHeight = 150;

  static Duration nextPageAnimationDuration = 500.milliseconds;
  static const nextPageAnimationCurve = Curves.fastEaseInToSlowEaseOut;
}
