part of on_boarding;

class OnBoardingPageView extends StatelessWidget {
  final PageController controller;
  const OnBoardingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      reverse: false,
      physics: const BouncingScrollPhysics(),
      pageSnapping: true,
      children: Constants.onBoardingImages
          .map(
            (e) => Image.asset(
              e,
              alignment: Alignment.bottomRight,
            ),
          )
          .toList(),
    );
  }
}
