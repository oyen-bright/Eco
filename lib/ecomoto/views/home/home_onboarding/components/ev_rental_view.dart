import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/app_colors.dart';
import '../constants/strings.dart';

class EvRentalFormView extends StatelessWidget {
  const EvRentalFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.nextAdventureRowImage),
            const SizedBox(
              width: AppSizes.size10,
            ),
            Text(
              Strings.forYourNextAdventureText,
              style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.primaryAccent),
            )
          ],
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          Strings.electricVehicleRentalText,
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w900, color: Colors.black, height: 1.2),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          Strings.evRentalDescriptionText,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium,
        )
      ],
    );
  }
}
