import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class CompanyAimView extends StatelessWidget {
  const CompanyAimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size20),
      width: double.infinity,
      height: 330,
      color: context.colorScheme.secondary,
      child: Stack(children: [
        Positioned(
          left: 10,
          top: 5,
          child: Image.asset(
            AppImages.companyAimDemoImage,
            scale: 1.5,
          ).withHorViewPadding,
        ),
        Positioned(
          right: AppSizes.size40,
          top: AppSizes.size40,
          child: _companyMission(context).withHorViewPadding,
        ),
        Positioned(
          bottom: 1,
          right: 10,
          left: 10,
          child: _companyVision(context).withHorViewPadding,
        ),
      ]),
    );
  }

  Widget _companyMission(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.size20),
      color: context.colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.companyMissionText,
            textAlign: TextAlign.left,
            style: context.textTheme.bodySmall!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
          const SizedBox(
            height: AppSizes.size4,
          ),
          Text(
            Strings.companyMissionDescText,
            style: context.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }

  Widget _companyVision(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.size10),
      color: context.colorScheme.primary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.companyVisionText,
            textAlign: TextAlign.left,
            style: context.textTheme.bodySmall!
                .copyWith(color: context.colorScheme.onPrimary),
          ),
          const SizedBox(
            height: AppSizes.size4,
          ),
          Text(
            Strings.companyVisionDescText,
            textAlign: TextAlign.left,
            style: context.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
