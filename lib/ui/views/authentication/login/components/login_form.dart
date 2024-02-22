part of '../login_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> with ValidationMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool loginWithWallet = true;

  String loginButtonPrompt = Strings.connectWalletButtonText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    if (AppEnvironment.isDevelopment) {
      _emailController.text = "oyen@ec.com";
      _passwordController.text = "11111111";
    }

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _changeLoginButtonPrompt();
    super.didChangeDependencies();
  }

  void _changeLoginMethod() {
    loginWithWallet = !loginWithWallet;

    _changeLoginButtonPrompt();
  }

  void _changeLoginButtonPrompt() async {
    context.read<WalletService>().getAvailableWallet().then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            if (value.walletType == UserWalletType.generatedWallet) {
              loginButtonPrompt = Strings.loginGenWalletButtonText;
            } else {
              loginButtonPrompt = Strings.loginButtonText;
            }
          });
        }
      }
      setState(() {});
    });
  }

  void _onContinueWithWallet() async {
    context.read<AuthCubit>().authenticateUserWithWallet(context: context);
  }

  void _onContinueWithPassword() async {
    if (_emailController.text.isNotEmpty) {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInAnonymously();
        context.removeFocus;
        context.read<AuthCubit>().authenticateUser(
            email: _emailController.text, password: _passwordController.text);
      }
    }
  }

  void onAuthenticationError(String errorMessage, bool isNewUser) async {
    context.showSnackBar(errorMessage, BarType.error);

    if (!isNewUser) {
      return;
    }
    final registerResponse = await (const SignUpApp().asBottomSheet<bool?>(
        context,
        enableDrag: false,
        bottomSafeArea: false,
        isDismissible: false));
    if (registerResponse != null && registerResponse) {
      return _onContinueWithWallet();
    }
  }

  void onAuthenticated(_, __, bool isFirstLogin) {
    isFirstLogin
        ? AppRouter.router.push(AppRoutes.completeProfile)
        : AppRouter.router.go(EcomotoRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
            authenticated: onAuthenticated, error: onAuthenticationError);
      },
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!loginWithWallet)
                ..._loginWithPassword
              else
                ..._loginWithWallet,
              ChangeLoginMethodButton(
                onPressed: _changeLoginMethod,
                isLoginWithWallet: loginWithWallet,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _loginWithWallet {
    return [
      const SizedBox(height: AppSizes.size20),
      AppElevatedButton(
        onPressed: _onContinueWithWallet,
        title: loginButtonPrompt,
      ),
      const SizedBox(
        height: AppSizes.size20,
      ),
      const GenerateWalletButton(),
    ];
  }

  List<Widget> get _loginWithPassword {
    return [
      AppTextField(
        autofillHints: const [AutofillHints.email],
        textInputAction: TextInputAction.next,
        validator: validateRequired,
        hintText: Strings.emailHintText,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
      ),
      const SizedBox(height: AppSizes.size20),
      AppTextField.password(
        autofillHints: const [AutofillHints.password],
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => _onContinueWithPassword(),
        validator: validateRequired,
        hintText: Strings.passwordHintText,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            AppRouter.router.go(AppRoutes.forgetPassword);
          },
          child: const Text(
            Strings.forgotPasswordText,
          ),
        ),
      ),
      AppElevatedButton(
        onPressed: _onContinueWithPassword,
        title: Strings.loginText,
      ),
      const SizedBox(
        height: AppSizes.size20,
      ),
    ];
  }
}
