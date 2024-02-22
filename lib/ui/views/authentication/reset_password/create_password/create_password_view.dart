library create_password;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/wrappers/auth_view_wrapper.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/create_password_form.dart';
part 'components/form_header_text.dart';
part 'constants/strings.dart';

class CreatePasswordView extends StatelessWidget {
  final String email;
  const CreatePasswordView({super.key, required this.email});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const FormHeaderText(),
                const SizedBox(
                  height: AppSizes.size20,
                ),
                CreatePasswordForm(
                  email: email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
