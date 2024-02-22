part of '../host_view.dart';

class VehicleDetailsTile extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailsTile({super.key, required this.vehicle});

  static Widget get shimmer {
    return AppShimmer(child: VehicleDetailsTile(vehicle: Vehicle.dummy()));
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = vehicle.carImages.firstWhere(
        (data) => data['imageUrl'] != null,
        orElse: () => {})['imageUrl'];

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      minVerticalPadding: 0,
      leading: SizedBox(
        width: 100,
        height: double.infinity,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
            child: imageUrl != null
                ? AppCachedImage(
                    imageUrl: imageUrl,
                    withPinata: true,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppImages.noVehicleImage,
                    fit: BoxFit.cover,
                  )),
      ),
      title: Text(
        vehicle.make,
        style: context.textTheme.titleSmall?.copyWith(),
      ),
      trailing: AppPopUpMenu(options: const [
        ('change_plan', 'Change Plan', null),
        ('edit_vehicle', 'Edit Vehicle', null),
        ('disable_vehicle', 'Disable Vehicle', Colors.red),
      ], isVertical: true, onSelected: (_) {}),
      subtitle: Text(
        "${vehicle.model} ${vehicle.year}",
        style: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.darkGreyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
