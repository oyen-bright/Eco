import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../router/app_router.dart';
import '../constants/strings.dart';

class GeneralSettingsForm extends StatefulWidget {
  const GeneralSettingsForm({
    super.key,
  });

  @override
  State<GeneralSettingsForm> createState() => GeneralSettingsFormState();
}

class GeneralSettingsFormState extends State<GeneralSettingsForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _addressController;
  late final TextEditingController _additionalAddressController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<UserCubit>().state.maybeWhen(
          details: (user) => user,
          orElse: () => null,
        );
    _firstNameController = TextEditingController(text: user?.firstName);
    _usernameController = TextEditingController(text: user?.username);
    _lastNameController = TextEditingController(text: user?.lastName);
    _addressController = TextEditingController();
    _additionalAddressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _additionalAddressController.dispose();
    super.dispose();
  }

  void _onSaved() async {
    // WalletConnectModal.service.openModal(context);
    context.removeFocus;

    final response = await context.read<UserCubit>().updateGeneralInfo(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text);

    if (context.mounted) {
      if (response.error != null) {
        context.showSnackBar(response.error, BarType.error);
      } else {
        context.showSnackBar(Strings.changesSaved, BarType.success);

        AppRouter.router.go(EcomotoRoutes.profileSettingsGeneral);
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
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            backgroundColor: context.colorScheme.secondary,
            fieldTitle: Strings.userNameTitleText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: _usernameController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            backgroundColor: context.colorScheme.secondary,
            fieldTitle: Strings.firstNameTitleText,
            textInputAction: TextInputAction.next,
            hintText: Strings.firstNameHintText,
            keyboardType: TextInputType.name,
            controller: _firstNameController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            backgroundColor: context.colorScheme.secondary,
            fieldTitle: Strings.lastNameTitleText,
            textInputAction: TextInputAction.next,
            hintText: Strings.lastNameHintText,
            keyboardType: TextInputType.name,
            controller: _lastNameController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            backgroundColor: context.colorScheme.secondary,
            fieldTitle: Strings.addressTitleText,
            hintText: Strings.addressHintText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: _addressController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withLabel(
            autofillHints: const [AutofillHints.email],
            backgroundColor: context.colorScheme.secondary,
            fieldTitle: Strings.additionalAddTitleText,
            hintText: Strings.additionalAddHintText,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            controller: _additionalAddressController,
          ),
          const SizedBox(
            height: AppSizes.size40,
          ),
          AppElevatedButton(
            title: Strings.saveChangeText,
            onPressed: _onSaved,
          )
        ],
      ),
    );
  }
}
