import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class CenterText extends StatelessWidget {
  const CenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            Strings.congratsText,
            style: context.textTheme.titleLarge!.copyWith(
                color: AppColors.rentalUsedColor, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            Strings.driveSafeText,
            textAlign: TextAlign.center,
            style: context.textTheme.titleSmall!.copyWith(
              color: AppColors.lowOpacityTextColor,
            ),
          ),
        )
      ],
    );
  }
}
