import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/sizes.dart';
import '../constants/strings.dart';

class NoMethodSaved extends StatelessWidget {
  const NoMethodSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.size300,
      width: AppSizes.size300 + AppSizes.size40,
      decoration: BoxDecoration(
          border:
              Border.all(color: context.colorScheme.onBackground, width: .25),
          borderRadius: BorderRadius.circular(AppSizes.size16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.noPaymentsMethodSavedImage,
            height: AppSizes.size120 + AppSizes.size40,
            width: AppSizes.size120 + AppSizes.size40,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Text(
            Strings.noSavedMethodsText,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: AppSizes.size12 + AppSizes.size2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: AppSizes.size200 + AppSizes.size60,
            child: Text(
              Strings.noSavedMethodsBodyText,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: AppSizes.size12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
