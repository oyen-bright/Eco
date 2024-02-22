part of '../vehicle_availability_view.dart';

class AvailabilityIndicator extends StatelessWidget {
  const AvailabilityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.availabilityText,
            style: context.textTheme.titleLarge
                ?.copyWith(color: AppColors.primaryColor),
          ),
        ),

        const SizedBox(
          height: AppSizes.size4,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(Strings.availabilityInfoText,
              style: context.textTheme.bodyMedium),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           height: AppSizes.size8 + AppSizes.size1,
        //           width: AppSizes.size8 + AppSizes.size1,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(1.5),
        //               border:
        //               Border.all(color: context.colorScheme.onBackground),
        //               color: context.colorScheme.onPrimary),
        //         ),
        //         const SizedBox(width: AppSizes.size4),

        //         Text(
        //           Strings.availableText,
        //           style: context.textTheme.titleSmall
        //               ?.copyWith(color: context.colorScheme.primary),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Container(
        //           height: AppSizes.size8 + AppSizes.size1,
        //           width: AppSizes.size8 + AppSizes.size1,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(1.5),
        //               border:
        //                   Border.all(color: context.colorScheme.onBackground),
        //               color: const Color(0xFFE3E2E8)),
        //         ),
        //         const SizedBox(width: AppSizes.size4),
        //         Text(
        //           Strings.unavailableText,
        //           style: context.textTheme.titleSmall
        //               ?.copyWith(color: context.colorScheme.primary),

        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        const SizedBox(
          height: AppSizes.size10,
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Text(
        //     Strings.updatedDateText,
        //     style: context.textTheme.bodySmall
        //         ?.copyWith(color: context.colorScheme.primary),
        //   ),
        // )
      ],
    );
  }
}
