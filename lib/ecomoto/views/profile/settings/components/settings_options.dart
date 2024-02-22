import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class ProfileSettingsOption extends StatelessWidget {
  const ProfileSettingsOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              AppRouter.router.go(EcomotoRoutes.profileSettingsGeneral);
            },
            child: Text(
              Strings.generalSettingsText,
              style: context.textTheme.titleLarge,
            )),
        const SizedBox(
          height: AppSizes.size20,
        ),
        TextButton(
            onPressed: () {
              AppRouter.router.go(EcomotoRoutes.profileSettingPassword);
            },
            child: Text(
              Strings.changePasswordText,
              style: context.textTheme.titleLarge,
            )),
        const SizedBox(
          height: AppSizes.size20,
        ),
        TextButton(
            onPressed: () {
              AppRouter.router.go(EcomotoRoutes.profileSettingsEmail);
            },
            child: Text(
              Strings.changeEmailText,
              style: context.textTheme.titleLarge,
            )),
      ],
    );
  }
}
