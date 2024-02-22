part of forget_password_otp;

class ForgetPasswordOtpFrom extends StatefulWidget {
  const ForgetPasswordOtpFrom({super.key});

  @override
  State<ForgetPasswordOtpFrom> createState() => ForgetPasswordOtpFromState();
}

class ForgetPasswordOtpFromState extends State<ForgetPasswordOtpFrom>
    with ValidationMixin {
  late final TextEditingController _otpController;

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerify() async {
    context.removeFocus;
    AppRouter.router.pushReplacement(
      AppRoutes.forgetPasswordChangeView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: AppSizes.size48,
          width: AppSizes.size200 + AppSizes.size70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: AppColors.vibrantColor.withOpacity(.20)),
          child: OtpInputField(
            onChanged: (value) {
              setState(() {
                if (value.length >= 8) {
                  context.removeFocus;
                }
              });
            },
            validator: validateRequired,
            controller: _otpController,
            hintText: Strings.enterCodeText,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.cantGetCodeText,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  Strings.resendText,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.vibrantColor),
                ))
          ],
        ),
        const SizedBox(height: AppSizes.size20),
        AppElevatedButton(
            title: Strings.verifyOtpText,
            onPressed: _otpController.text.length >= 8 ? _onVerify : null)
      ],
    );
  }
}
