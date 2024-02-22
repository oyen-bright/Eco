part of email_verification;

class OtpSentHeader extends StatelessWidget {
  final String enteredEmail;
  const OtpSentHeader({super.key, required this.enteredEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AutoSizeText(
                "Activate your account",
                style: AppTextStyles.authSectionHeaderTextStyle,
                maxLines: 2,
              ),
              AutoSizeText(
                "Please go to your inbox and retrieve your 8-digit one-time-password(OTP) to activate your account",
                style: context.textTheme.bodyMedium,
                maxLines: 2,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSizes.size40,
        ),
        // SizedBox(
        //   child: Image.asset(
        //     AppImages.emailSentImage,
        //     scale: 1.7,
        //   ),
        // ),
        // const SizedBox(
        //   height: AppSizes.size40,
        // ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: context.colorScheme.secondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.otpSentText, style: context.textTheme.bodySmall),
              Text(
                enteredEmail,
                style: context.textTheme.titleSmall,
              )
            ],
          ),
        )
      ],
    );
  }
}
