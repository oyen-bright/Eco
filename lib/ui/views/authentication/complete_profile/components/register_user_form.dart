part of complete_profile;

class RegisterUserForm extends StatefulWidget {
  const RegisterUserForm({
    super.key,
  });

  @override
  State<RegisterUserForm> createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm>
    with ValidationMixin {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;

      final response = await context.read<UserCubit>().registerUser(
          username: _userNameController.text,
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text);
      if (context.mounted) {
        if (response.error == null) {
          context.showSnackBar(Strings.userRegisteredSuccess);
          AppRouter.router.go(
            EcomotoRoutes.home,
          );
        } else {
          context.showSnackBar(response.error, BarType.error);
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
          AppTextField.withColor(
            backgroundColor: AppColors.registerFormColor,
            autofillHints: const [AutofillHints.username],
            controller: _userNameController,
            fieldTitle: Strings.userNameText,
            hintText: Strings.userNameHintText,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withColor(
            backgroundColor: AppColors.registerFormColor,
            autofillHints: const [AutofillHints.password],
            controller: _oldPasswordController,
            showObscureTextIcon: true,
            fieldTitle: Strings.oldPasswordText,
            hintText: Strings.oldPasswordHintText,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withColor(
            backgroundColor: AppColors.registerFormColor,
            showObscureTextIcon: true,
            autofillHints: const [AutofillHints.password],
            controller: _newPasswordController,
            fieldTitle: Strings.newPasswordText,
            hintText: Strings.newPasswordHintText,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField.withColor(
            backgroundColor: AppColors.registerFormColor,
            showObscureTextIcon: true,
            autofillHints: const [AutofillHints.password],
            controller: _confirmNewPasswordController,
            fieldTitle: Strings.confirmPasswordText,
            hintText: Strings.confirmNewPasswordHintText,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AppSizes.size30),
          AppElevatedButton(
            isLoading: isLoading,
            onPressed: isLoading ? null : _onRegister,
            title: Strings.registerText,
          ),
          const SizedBox(height: AppSizes.size30),
        ],
      ),
    );
  }
}
