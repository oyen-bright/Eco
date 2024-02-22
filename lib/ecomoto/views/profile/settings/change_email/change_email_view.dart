import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/profile_header.dart';
import 'package:emr_005/ecomoto/views/profile/settings/change_email/components/change_email_form.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

import 'components/form_header_text.dart';
import 'constants/strings.dart';

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileViewWrapper(
      actions: [
        ProfileHeader(
          foregroundColor: context.colorScheme.onPrimary,
        )
      ],
      background: const SizedBox.shrink(),
      title: Strings.emailSettingsText,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: AppSizes.size20,
          ),
          FormHeaderText(),
          SizedBox(
            height: AppSizes.size10,
          ),
          ChangeEmailForm()
        ],
      ),
    );
  }
}
