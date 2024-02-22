part of splash;

@immutable
class Constants {
  const Constants._();

  static const int splashDelay = 2;
  static const double bottomImageScale = .95;
  static const double centerLogoScale = .85;
  static const double centerTextFontSize = 35;

  static Duration animationDuration = 2.seconds;
  static Duration centerContentInterval = 400.ms;
  static Duration centerContentFadeDuration = 300.ms;
}
