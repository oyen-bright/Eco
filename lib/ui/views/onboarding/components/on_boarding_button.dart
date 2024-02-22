part of on_boarding;

class OnBoardingButton extends StatelessWidget {
  final PageController controller;

  const OnBoardingButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    void onButtonPressed(bool isLastPage) async {
      if (isLastPage) {
        await AppConfig.setFinishedOnboarding(true);
        AppRouter.router.pushReplacement(AppRoutes.login);
      } else {
        controller.nextPage(
            duration: Constants.nextPageAnimationDuration,
            curve: Constants.nextPageAnimationCurve);
      }
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          bool isLastPage = (controller.page?.round() ?? 0) ==
              Constants.onBoardingPrompts.length - 1;

          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingHorizontal),
              child: ElevatedButton(
                onPressed: () => onButtonPressed(isLastPage),
                style: ElevatedButton.styleFrom(
                  minimumSize: Constants.onBoardingButtonMinimumSize,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLastPage ? Strings.signUpButton : Strings.nextButton,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: AppSizes.size8),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
