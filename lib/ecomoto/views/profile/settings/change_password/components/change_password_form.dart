import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/user_cubit/user_cubit.dart';
import '../../../../../../../router/app_router.dart';
import '../constants/strings.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
  });

  @override
  State<ChangePasswordForm> createState() => ChangePasswordFormState();
}

class ChangePasswordFormState extends State<ChangePasswordForm>
    with ValidationMixin {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _onSaved() async {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        context.showSnackBar(Strings.passwordMismatch, BarType.error);
      } else {
        context.removeFocus;

        final response = await context.read<UserCubit>().changePassword(
            oldPassword: _oldPasswordController.text,
            newPassword: _newPasswordController.text);

        if (mounted) {
          if (response.error != null) {
            context.showSnackBar(response.error, BarType.error);
          } else {
            context.showSnackBar(Strings.passwordChangedText);
            AppRouter.router.go(AppRoutes.login);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: AppSizes.size20),
          AppTextField.password(
            autofillHints: const [AutofillHints.email],
            fieldTitle: Strings.oldPasswordText,
            textInputAction: TextInputAction.next,
            validator: validatePassword,
            hintText: Strings.oldPasswordHintText,
            keyboardType: TextInputType.name,
            controller: _oldPasswordController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.password(
            autofillHints: const [AutofillHints.email],
            fieldTitle: Strings.newPasswordText,
            textInputAction: TextInputAction.next,
            validator: validatePassword,
            hintText: Strings.newPasswordHintText,
            keyboardType: TextInputType.name,
            controller: _newPasswordController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.password(
            autofillHints: const [AutofillHints.email],
            fieldTitle: Strings.confirmNewPasswordText,
            validator: validatePassword,
            hintText: Strings.confirmNewPasswordHintText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: _confirmNewPasswordController,
          ),
          const SizedBox(
            height: AppSizes.size40,
          ),
          AppElevatedButton(
            title: Strings.changePasswordButtonText,
            onPressed: _onSaved,
          )
        ],
      ),
    );
  }
}
