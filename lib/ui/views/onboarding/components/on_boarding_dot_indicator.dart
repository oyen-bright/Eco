part of on_boarding;

class DotIndicator extends StatelessWidget {
  final PageController controller;
  const DotIndicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          int currentPage = controller.page?.round() ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingHorizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                3,
                (index) {
                  bool isActive = currentPage == index;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: Constants.dotIndicatorSize.width,
                    height: Constants.dotIndicatorSize.height,
                    decoration: BoxDecoration(
                      color: isActive
                          ? context.colorScheme.primary
                          : context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(
                          Constants.dotIndicatorBorderRadius),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
