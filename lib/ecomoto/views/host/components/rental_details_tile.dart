part of '../host_view.dart';

class RentalDetailsTile extends StatelessWidget {
  final Trip trip;
  final int? notificationCount;
  final void Function()? onTap;
  const RentalDetailsTile(
      {super.key, required this.trip, this.onTap, this.notificationCount});

  static Widget get shimmer {
    return AppShimmer(child: RentalDetailsTile(trip: Trip.dummy()));
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = trip.carDetails.carImages.firstWhere(
        (data) => data['imageUrl'] != null,
        orElse: () => {})['imageUrl'];

    return ListTile(
      onTap: onTap,
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
        trip.carDetails.make,
        style: context.textTheme.titleSmall?.copyWith(),
      ),
      trailing: InkWell(
        onTap: onTap,
        child: Badge.count(
          alignment: Alignment.topRight,
          isLabelVisible: (notificationCount != null && notificationCount != 0),
          offset: const Offset(-5, 0),
          count: notificationCount ?? 0,
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.lightGreenBorderColor),
            child: Image.asset(
              AppImages.chatIcon,
              scale: 2.5,
              color: AppColors.lockUnlockGreen,
            ),
          ),
        ),
      ),
      subtitle: Text(
        "${trip.carDetails.model} ${trip.carDetails.year}",
        style: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.darkGreyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
