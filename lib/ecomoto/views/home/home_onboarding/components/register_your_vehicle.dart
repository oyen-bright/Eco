import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

import '../../../../../../themes/sizes.dart';
import '../constants/strings.dart';

class RegisterYourEVHomeView extends StatelessWidget {
  const RegisterYourEVHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppSizes.size60),
          height: context.viewSize.height * .30,
          width: context.viewSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            gradient: const RadialGradient(
              center: Alignment.center,
              radius: 2,
              colors: [
                Color(0xFF2FF77A),
                Color(0xFF00A1FF),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 1,
            right: 5,
            left: 5,
            child: Image.asset(
              AppImages.registerVehicleHomeImage,
              scale: 1.15,
            )),
        Positioned(top: 20, right: 35, left: 35, child: _textColumn(context))
      ],
    );
  }

  Widget _textColumn(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.hostOrLesseeQuestionText,
          style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onBackground),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            Strings.registerOrRentVehicleText,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall,
          ),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        Transform.scale(
            scale: .85,
            child: AppElevatedButton(
              title: Strings.registerYourVehicleNowText,
              onPressed: () {},
              titleColor: context.colorScheme.primary,
              backgroundColor: context.colorScheme.onPrimary,
            ))
      ],
    );
  }
}
