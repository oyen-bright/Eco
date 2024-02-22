part of '../trips_view.dart';

class TripDetailsTile extends StatelessWidget {
  final Trip tripDetails;
  final void Function()? onTap;
  const TripDetailsTile(
      {super.key, required this.tripDetails, required this.onTap});

  static Widget get shimmer {
    return AppShimmer(
        child: TripDetailsTile(tripDetails: Trip.dummy(), onTap: null));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 90,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                child: (tripDetails.carDetails.carImages.isNotEmpty)
                    ? AppCachedImage(
                        imageUrl: (tripDetails.carDetails.carImages..shuffle())
                            .first['imageUrl'],
                        withPinata: true,
                      )
                    : Image.asset(
                        AppImages.noVehicleImage,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${Strings.bookingIDTitle}: #${tripDetails.id}",
                      maxLines: 1,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${Strings.plateNumberTitle}: ',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.30,
                        ),
                      ),
                      TextSpan(
                        text: tripDetails.carDetails.plateNumber ?? "N/A",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${Strings.colorTitle}: ',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.30,
                        ),
                      ),
                      TextSpan(
                        text: tripDetails.carDetails.color,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkGreyColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ])),
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: tripDetails.rentalStatus != null &&
                              tripDetails.rentalStatus != RentalStatus.completed
                          ? AppColors.rentActiveColorLight
                          : AppColors.rentCompletedColorLight,
                      borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusSmall)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.size10, vertical: AppSizes.size6),
                  child: Text(
                    (tripDetails.rentalStatus?.value ?? "N/A").toString(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: tripDetails.rentalStatus != null &&
                              tripDetails.rentalStatus != RentalStatus.completed
                          ? AppColors.rentActiveColor
                          : AppColors.rentCompletedColor,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
