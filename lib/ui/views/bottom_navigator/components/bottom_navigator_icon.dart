part of app_bottom_navigator;

class BottomNavigationIcon extends StatelessWidget {
  final Color? color;
  final String name;
  const BottomNavigationIcon({
    Key? key,
    required this.name,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = Constants.iconSize;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size4),
      child: Image.asset(
        name,
        height: iconSize.height,
        width: iconSize.width,
        color: color,
      ),
    );
  }
}
