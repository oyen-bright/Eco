import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/profile_header.dart';
import 'package:emr_005/ecomoto/views/profile/settings/components/settings_options.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import 'constants/strings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileViewWrapper(
      automaticallyImplyLeading: true,
      actions: [
        ProfileHeader(
          foregroundColor: context.colorScheme.onPrimary,
        )
      ],
      title: Strings.settingsText,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: AppSizes.size10,
          ),
          ProfileSettingsOption()
        ],
      ),
    );
  }
}
