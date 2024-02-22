part of '../host_view.dart';

class ListVehicleFAB extends StatelessWidget {
  const ListVehicleFAB({super.key});

  @override
  Widget build(BuildContext context) {
    void onVehicleListing() async {
      // AppRouter.router.push(EcomotoRoutes.vehicleListingSelectPlan);
      AppRouter.router.push(EcomotoRoutes.vehicleListing);

      // testSmartCar(context);
      // // AppRouter.router.push(EcomotoRoutes.vehicleListing);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.fabPadding),
      child: FloatingActionButton.extended(
        heroTag: null,
        foregroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
        extendedPadding:
            const EdgeInsets.symmetric(horizontal: AppConstants.fabPadding),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: context.colorScheme.primary,
        onPressed: onVehicleListing,
        label: AppElevatedButton.withIcon(
          borderRadius: BorderRadius.circular(0),
          disabledBackgroundColor: Colors.transparent,
          icon: Icons.arrow_forward,
          borderColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Strings.fABTitle,
          onPressed: onVehicleListing,
        ),
      ),
    );
  }
}
