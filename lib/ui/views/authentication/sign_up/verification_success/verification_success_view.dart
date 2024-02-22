library verification_success;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/utils/clipboard_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../../router/app_router.dart';
import '../../../../../../../themes/app_images.dart';
import '../../../../../ui/components/wrappers/auth_view_wrapper.dart';

part 'components/complete_registration_button.dart';
part 'components/generated_password.dart';
part 'components/otp_verification_successful.dart';
part 'constants/strings.dart';

class VerificationSuccessView extends StatelessWidget {
  final String generatedPassword;
  const VerificationSuccessView({super.key, required this.generatedPassword});

  @override
  Widget build(BuildContext context) {
    return AuthViewWrapper(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: AppConstants.authenticationMaxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const OtpVerificationSuccessful(),
                const SizedBox(
                  height: AppSizes.size40,
                ),
                GeneratedPassword(
                  password: generatedPassword,
                ),
                const SizedBox(
                  height: AppSizes.size36,
                ),
                const CompleteRegistrationButton(),
                const SizedBox(
                  height: AppSizes.size120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
