part of '../vehicle_onboarding_view.dart';

class GetStartedButton extends StatelessWidget with SmartCarMixin {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButtonWithIcon(
      navigateForward: true,
      title: Strings.startedButtonText,
      onPressed: () async {
        final res = await connectSmartCar(context);

        if (res != null) {
          AppRouter.router
              .push(EcomotoRoutes.vehicleListingSelectSmartCar, extra: res);
        }
      },
    );
  }
}
