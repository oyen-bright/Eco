part of app_bottom_navigator;

class CustomNavBarItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final bool isCircle;
  final int? count;

  final Color? circleBackgroundColor;
  final void Function()? onTap;

  const CustomNavBarItem._({
    Key? key,
    required this.circleBackgroundColor,
    required this.icon,
    required this.label,
    required this.isCircle,
    required this.isSelected,
    required this.onTap,
    this.count,
  }) : super(key: key);

  factory CustomNavBarItem({
    required String icon,
    required String label,
    final int? count,
    required bool isSelected,
    required void Function()? onTap,
  }) {
    return CustomNavBarItem._(
      isCircle: false,
      count: count,
      icon: icon,
      circleBackgroundColor: null,
      label: label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  factory CustomNavBarItem.circle({
    required String icon,
    required String label,
    required bool isSelected,
    required Color backgroundColor,
    required void Function()? onTap,
  }) {
    return CustomNavBarItem._(
      isCircle: true,
      circleBackgroundColor: backgroundColor,
      icon: icon,
      label: label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarThemeData = context.theme.bottomNavigationBarTheme;
    const Size iconSize = Size(AppSizes.size24, AppSizes.size24);

    return InkWell(
      onTap: () {
        onTap?.call();
        haptic(HapticFeedbackType.selection);
      },
      child: isCircle
          ? Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleBackgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    icon,
                    height: iconSize.height,
                    width: iconSize.width,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    label,
                    maxLines: 2,
                    style: isSelected
                        ? bottomNavigationBarThemeData.selectedLabelStyle
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                        : bottomNavigationBarThemeData.unselectedLabelStyle
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Badge.count(
                  isLabelVisible: (count != null && count != 0),
                  count: count ?? 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.size4),
                    child: Image.asset(
                      icon,
                      height: iconSize.height,
                      width: iconSize.width,
                      color: !isSelected
                          ? AppColors.inActiveBottomNavigationColor
                          : AppColors.primaryColor,
                    ),
                  ),
                ),
                Text(
                  label,
                  style: isSelected
                      ? bottomNavigationBarThemeData.selectedLabelStyle
                          ?.copyWith(
                              color: bottomNavigationBarThemeData
                                  .selectedItemColor)
                      : bottomNavigationBarThemeData.unselectedLabelStyle
                          ?.copyWith(
                              color: bottomNavigationBarThemeData
                                  .unselectedItemColor),
                ),
              ],
            ),
    );
  }
}
