library forget_password_otp;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/otp_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:flutter/material.dart';

part 'components/forget_password_otp_form.dart';
part 'components/form_header_image.dart';
part 'components/form_header_text.dart';
part 'components/otp_sent_text.dart';
part 'constants/strings.dart';

class ForgetPasswordOtpView extends StatelessWidget {
  final String enteredEmail;
  const ForgetPasswordOtpView({super.key, required this.enteredEmail});

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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: AppSizes.size20,
              ),
              const FormHeaderImage(),
              const SizedBox(
                height: AppSizes.size40,
              ),
              const FormHeaderText(),
              const SizedBox(
                height: AppSizes.size40,
              ),
              ForgetPasswordOtpSentText(enteredEmail: enteredEmail),
              const SizedBox(
                height: AppSizes.size20,
              ),
              const ForgetPasswordOtpFrom(),
            ],
          ),
        ),
      ),
    ));
  }
}
