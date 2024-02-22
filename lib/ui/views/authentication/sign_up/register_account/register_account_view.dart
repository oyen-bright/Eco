library register_account;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:emr_005/ui/views/authentication/sign_up/router/routes.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/loading_cubit.dart';
import '../router/navigator.dart';

part 'components/form_header_text.dart';
part 'components/register_form.dart';
part 'components/social_sign_up.dart';
part 'components/terms_and_policy_button.dart';
part 'constants/strings.dart';

class RegisterAccountView extends StatelessWidget {
  const RegisterAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthViewWrapper(
      showCancelButton: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: AppConstants.authenticationMaxWidth),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                FormHeaderText(),
                SizedBox(
                  height: AppSizes.size40,
                ),
                SignUpForm(),
                SizedBox(
                  height: AppSizes.size40,
                ),
                TermsAndPolicyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
