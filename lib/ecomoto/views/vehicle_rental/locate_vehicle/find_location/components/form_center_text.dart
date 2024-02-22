import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class FormCenterText extends StatelessWidget {
  const FormCenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSizes.size16,
        ),
        Text(
          Strings.findingLocationText,
          style: context.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.rentalDateViewColor),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        Text(
          Strings.locationDescText,
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall!
              .copyWith(color: AppColors.lowOpacityTextColor),
        )
      ],
    );
  }
}
