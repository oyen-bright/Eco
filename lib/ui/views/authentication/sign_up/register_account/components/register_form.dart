part of register_account;

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with ValidationMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  final _formKey = GlobalKey<FormState>();

  void _onSignUp() async {
    if (_formKey.currentState!.validate()) {
      context.removeFocus;
      final enteredEmail = _emailController.text;
      final phoneNumber = _phoneController.text;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      context.read<AuthLoadingCubit>().loading();

      context
          .read<UserCubit>()
          .createUserAccount(
              email: enteredEmail,
              phone: phoneNumber,
              firstName: firstName,
              lastName: lastName)
          .then((response) {
        if (mounted) {
          context.read<AuthLoadingCubit>().loaded();
          if (response.error != null) {
            context.showSnackBar(response.error, BarType.error);
          } else {
            context.showSnackBar(Strings.otpSentText);
            AuthRouter.push(AuthRoutes.activateAccount, arguments: {
              "email": enteredEmail,
              "phone": phoneNumber,
              "firstName": firstName,
              "lastName": lastName
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          AppTextField(
            fieldTitle: Strings.firstNameTitle,
            autofillHints: const [AutofillHints.givenName],
            validator: validateRequired,
            textInputAction: TextInputAction.next,
            hintText: Strings.firstNameHintText,
            keyboardType: TextInputType.name,
            controller: _firstNameController,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          AppTextField(
            fieldTitle: Strings.lastNameTitle,
            autofillHints: const [AutofillHints.familyName],
            validator: validateRequired,
            textInputAction: TextInputAction.next,
            hintText: Strings.lastNameHintText,
            keyboardType: TextInputType.name,
            controller: _lastNameController,
          ),
          const SizedBox(height: AppSizes.size20),
          AppTextField(
            fieldTitle: Strings.emailTitle,
            autofillHints: const [AutofillHints.email],
            validator: validateEmail,
            textInputAction: TextInputAction.next,
            hintText: Strings.emailHintText,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          AppTextField(
            fieldTitle: Strings.phoneTitle,
            autofillHints: const [AutofillHints.telephoneNumber],
            validator: validatePhoneNumber,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onSignUp(),
            hintText: Strings.phoneHintText,
            keyboardType: TextInputType.number,
            controller: _phoneController,
          ),
          const SizedBox(height: AppSizes.size30),
          AppElevatedButton(
            onPressed: _onSignUp,
            title: Strings.continueWithEmailText,
          ),
          const SizedBox(height: AppSizes.size20),
        ],
      ),
    );
  }
}
