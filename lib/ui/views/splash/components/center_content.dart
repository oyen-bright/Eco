part of splash;

class CenterContent extends StatelessWidget {
  const CenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Image.asset(
            AppImages.logo,
            scale: Constants.centerLogoScale,
          ),
        ),
        Text(
          AppConstants.appName.toUpperCase(),
          style: const TextStyle(
            fontFamily: AppTextStyles.receiptFontFamily,
            fontSize: Constants.centerTextFontSize,
            color: AppColors.primaryColor,
          ),
        ),
      ]
          .animate(interval: Constants.centerContentInterval)
          .fade(duration: Constants.centerContentFadeDuration),
    );
  }
}
