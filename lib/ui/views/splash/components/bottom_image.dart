part of splash;

class BottomImage extends StatelessWidget {
  const BottomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Image.asset(
        AppImages.splashBottomImage,
        scale: Constants.bottomImageScale,
      ),
    ).animate().fade(duration: Constants.animationDuration);
  }
}
