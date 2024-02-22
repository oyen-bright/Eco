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

class ChangeEmailForm extends StatefulWidget {
  const ChangeEmailForm({
    super.key,
  });

  @override
  State<ChangeEmailForm> createState() => ChangeEmailFormState();
}

class ChangeEmailFormState extends State<ChangeEmailForm> with ValidationMixin {
  late final TextEditingController _newEmailController;
  late final TextEditingController _ecomotoPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _newEmailController = TextEditingController();
    _ecomotoPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _ecomotoPasswordController.dispose();
    super.dispose();
  }

  void _onSaved() async {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;
      final response = await context.read<UserCubit>().changeEmail(
          password: _ecomotoPasswordController.text,
          newEmail: _newEmailController.text);

      if (context.mounted) {
        if (response.error != null) {
          context.showSnackBar(response.error, BarType.error);
        } else {
          context.showSnackBar(Strings.emailChangedText);
          AppRouter.router.go(AppRoutes.login);
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
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            fieldTitle: Strings.newEmailText,
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            hintText: Strings.newEmailHintText,
            keyboardType: TextInputType.name,
            controller: _newEmailController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.password(
            autofillHints: const [AutofillHints.email],
            fieldTitle: Strings.ecomotoPasswordText,
            textInputAction: TextInputAction.next,
            validator: validatePassword,
            hintText: Strings.ecomotoPasswordHintText,
            keyboardType: TextInputType.name,
            controller: _ecomotoPasswordController,
          ),
          const SizedBox(
            height: AppSizes.size40,
          ),
          AppElevatedButton(
            title: Strings.changeEmailButtonText,
            onPressed: _onSaved,
          )
        ],
      ),
    );
  }
}
