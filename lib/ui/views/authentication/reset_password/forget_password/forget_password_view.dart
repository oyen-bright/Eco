library forget_password;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/forget_password_form.dart';
part 'components/form_header_image.dart';
part 'components/form_header_text.dart';
part 'components/login_button.dart';
part 'constants/strings.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppSizes.size20,
                ),
                FormHeaderImage(),
                SizedBox(
                  height: AppSizes.size40,
                ),
                FormHeaderText(),
                SizedBox(
                  height: AppSizes.size20,
                ),
                ForgetPasswordForm(),
                SizedBox(
                  height: AppSizes.size20,
                ),
                LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
