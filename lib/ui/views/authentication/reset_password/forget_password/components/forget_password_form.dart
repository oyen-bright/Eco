part of forget_password;

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  State<ForgetPasswordForm> createState() => ForgetPasswordFormState();
}

class ForgetPasswordFormState extends State<ForgetPasswordForm>
    with ValidationMixin {
  late final TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onProceed() async {
    final enteredEmail = _emailController.text;

    if (_formKey.currentState!.validate()) {
      final response =
          await context.read<UserCubit>().forgetPassword(email: enteredEmail);

      if (mounted) {
        if (response.error != null) {
          context.showSnackBar(response.error, BarType.error);
        } else {
          context.showSnackBar(
            response.message,
          );

          AppRouter.router
              .push(AppRoutes.forgetPasswordChangeView, extra: enteredEmail);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppSizes.size20,
            ),
            AppTextField(
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              validator: validateEmail,
              onFieldSubmitted: (_) => _onProceed(),
              fieldTitle: Strings.emailTitleText,
              hintText: Strings.emailHintText,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: AppSizes.size20),
            AppElevatedButton(
              onPressed: _onProceed,
              title: Strings.submitButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
