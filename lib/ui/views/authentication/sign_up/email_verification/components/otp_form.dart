part of email_verification;

class OtpForm extends StatelessWidget {
  final Map<String, String> userData;

  const OtpForm({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    void onVerify() async {
      context.removeFocus;
      context.read<AuthLoadingCubit>().loading();
      context
          .read<UserCubit>()
          .otpVerification(otp: otpController.text)
          .then((response) {
        if (context.mounted) {
          context.read<AuthLoadingCubit>().loaded();
          if (response.password != null) {
            context.showSnackBar(Strings.otpVerifiedText);
            AuthRouter.replace(AuthRoutes.verificationSuccess,
                arguments: response.password);
          } else {
            context.showSnackBar(response.error, BarType.error);
          }
        }
      });
    }

    void onResendCode() async {
      // context.removeFocus;
      // final response = await context
      //     .read<UserCubit>()
      //     .userSignUp(email: email, phone: phone);
      // if (context.mounted) {
      //   if (response.error != null) {
      //     context.showSnackBar(response.error, BarType.error);
      //   } else {
      //     otpController.clear();
      //     context.showSnackBar(Strings.otpSentText);
      //   }
      // }
    }

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
            controller: otpController,
            hintText: Strings.enterCodeText,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.codeNotReceivedText,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: onResendCode,
                child: Text(
                  Strings.resendCodeText,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.vibrantColor),
                ))
          ],
        ),
        const SizedBox(height: AppSizes.size20),
        AppElevatedButton(title: Strings.verifyText, onPressed: onVerify)
      ],
    );
  }
}
