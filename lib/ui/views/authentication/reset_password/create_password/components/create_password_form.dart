part of create_password;

class CreatePasswordForm extends StatefulWidget {
  final String email;
  const CreatePasswordForm({
    super.key,
    required this.email,
  });

  @override
  State<CreatePasswordForm> createState() => CreatePasswordFormState();
}

class CreatePasswordFormState extends State<CreatePasswordForm>
    with ValidationMixin {
  bool isLoading = false;

  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _otpController;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final response = await context.read<UserCubit>().resetPassword(
          email: widget.email,
          token: _otpController.text,
          password: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text);
      if (mounted) {
        if (response.error != null) {
          context.showSnackBar(response.error, BarType.error);
        } else {
          context.showSnackBar(response.message);
          AppRouter.router.go(AppRoutes.login);
        }
      }
    }
  }

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _otpController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppTextField.otp(
              onChanged: (value) {
                if (value.length >= 8) {
                  context.removeFocus;
                }
                setState(() {});
              },
              autofillHints: const [AutofillHints.oneTimeCode],
              textInputAction: TextInputAction.next,
              hintText: Strings.enterCodeText,
              fieldTitle: Strings.enterCodeText,
              keyboardType: TextInputType.emailAddress,
              controller: _otpController,
            ),
            const SizedBox(height: AppSizes.size20),
            AppTextField.password(
              autofillHints: const [AutofillHints.password],
              validator: validatePassword,
              showHiddenIcon: false,
              textInputAction: TextInputAction.next,
              hintText: Strings.newPassHintText,
              fieldTitle: Strings.newPasswordTitleText,
              keyboardType: TextInputType.emailAddress,
              controller: _newPasswordController,
            ),
            const SizedBox(height: AppSizes.size20),
            AppTextField.password(
              autofillHints: const [AutofillHints.password],
              validator: (value) =>
                  validatePasswordConfirm(value, _newPasswordController.text),
              fieldTitle: Strings.confirmNewPasswordTitleText,
              textInputAction: TextInputAction.done,
              hintText: Strings.confirmPassHintText,
              keyboardType: TextInputType.emailAddress,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: AppSizes.size20),
            AppElevatedButton(
              onPressed: _otpController.text.length < 8 ? null : _onSubmit,
              title: Strings.submitButtonText,
            ),
            const SizedBox(height: AppSizes.size20),
          ],
        ),
      ),
    );
  }
}
