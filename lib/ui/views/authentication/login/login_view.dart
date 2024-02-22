library login;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/auth_cubit/auth_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:emr_005/ui/views/authentication/login/components/wallet_details.dart';
import 'package:emr_005/ui/views/authentication/sign_up/app.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part './constants/strings.dart';
part 'components/connect_with_wallet_button.dart';
part 'components/form_header_text.dart';
part 'components/login_form.dart';
part 'components/login_with_password_button.dart';
part 'components/new_web3_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthViewWrapper(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: AppConstants.authenticationMaxWidth),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                FormHeaderText(),
                SizedBox(
                  height: AppSizes.size20,
                ),
                LoginForm(),
                SizedBox(
                  height: AppSizes.size45,
                ),
                NewToWeb3()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
