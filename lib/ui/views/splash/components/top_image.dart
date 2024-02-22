part of splash;

class TopImage extends StatelessWidget {
  const TopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Image.asset(AppImages.splashTopImage)
          .animate()
          .fade(duration: Constants.animationDuration),
    );
  }
}
