part of '../listing_successful_view.dart';

class BackToHomePage extends StatelessWidget {
  const BackToHomePage({super.key});

  void _onProceed() async {
    AppRouter.router.go(EcomotoRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      title: Strings.homepageButtonText,
      onPressed: _onProceed,
    );
  }
}
