import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class HowItWorksHomeView extends StatelessWidget {
  const HowItWorksHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              Strings.howItWorksTitleText,
              style: context.textTheme.titleLarge,
            )),
        Align(
            alignment: Alignment.center,
            child: Text(
              Strings.howItWorksStepsText,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            )),
        Image.asset(AppImages.howItWorksImage),
        _row(context, AppImages.selectVehicleImage,
            Strings.selectVehicleTitleText, Strings.selectVehicleDescText),
        _row(context, AppImages.pickUpTimeImage, Strings.pickDateTimeTitleText,
            Strings.pickDateTimeDescText),
        _row(
            context,
            AppImages.driveYourCarImage,
            Strings.driveYourVehicleTitleText,
            Strings.driveYourVehicleDescText),
      ],
    );
  }

  Widget _row(BuildContext context, String imageAsset, String stringText,
      String descStringText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(imageAsset),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stringText,
              style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorScheme.onBackground,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .65,
              child: Text(descStringText, style: context.textTheme.bodyMedium),
            )
          ],
        )
      ],
    );
  }
}
