part of '../trips_view.dart';

class FindVehicleFAB extends StatelessWidget {
  const FindVehicleFAB({super.key});

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => context.go(EcomotoRoutes.homeAllVehicles),
        label: AppElevatedButton.withIcon(
          borderRadius: BorderRadius.circular(0),
          disabledBackgroundColor: Colors.transparent,
          icon: Icons.arrow_forward,
          borderColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Strings.findACar,
          onPressed: null,
        ),
      ),
    );
  }
}
