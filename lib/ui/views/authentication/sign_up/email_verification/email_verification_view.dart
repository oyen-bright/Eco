library email_verification;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/otp_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:emr_005/ui/views/authentication/sign_up/cubit/loading_cubit.dart';
import 'package:emr_005/ui/views/authentication/sign_up/router/navigator.dart';
import 'package:emr_005/ui/views/authentication/sign_up/router/routes.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './components/edit_email_button.dart';
part './components/otp_form.dart';
part './components/otp_sent_header.dart';
part './components/terms_and_policy.dart';
part './constants/strings.dart';

class EmailVerificationView extends StatelessWidget {
  final Map<String, String> userData;
  const EmailVerificationView({
    super.key,
    required this.userData,
  });

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                OtpSentHeader(enteredEmail: userData['email'] ?? ""),
                const SizedBox(
                  height: AppSizes.size20,
                ),
                OtpForm(
                  userData: userData,
                ),
                const TermsAndPolicy(),
                const SizedBox(
                  height: AppSizes.size20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
