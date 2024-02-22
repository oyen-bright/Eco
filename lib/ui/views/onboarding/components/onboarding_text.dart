part of on_boarding;

class OnBoardingText extends StatelessWidget {
  final PageController controller;
  const OnBoardingText({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        int currentPage = controller.page?.round() ?? 0;

        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal,
              vertical: AppSizes.size10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Constants.onBoardingPrompts[currentPage]['title'] ?? "",
                style: AppTextStyles.onboardingTextTitle,
              ),
              Text(
                Constants.onBoardingPrompts[currentPage]['subtitle'] ?? "",
                style: AppTextStyles.onboardingTextSubtitle,
                textAlign: TextAlign.left,
              ),
            ].animate().fadeIn(),
          ),
        );
      },
    );
  }
}
