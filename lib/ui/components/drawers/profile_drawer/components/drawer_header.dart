part of '../dashboard_drawer.dart';

class ProfileDrawerHeader extends StatelessWidget {
  const ProfileDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.profileLogo,
      scale: 2,
    );
  }
}
