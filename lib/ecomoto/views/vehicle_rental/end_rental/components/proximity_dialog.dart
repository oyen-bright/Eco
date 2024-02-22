part of '../end_rental.dart';

class ProximityDialog extends StatelessWidget {
  const ProximityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 60),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: AppSizes.size10,
          ),
          Image.asset(
            AppImages.proximityIcon,
            scale: 2,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Text(
            Strings.proximityEndTripTitle,
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Text(
            Strings.proximityEndTripSubtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
        ],
      ),
    );
  }
}
