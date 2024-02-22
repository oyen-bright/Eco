part of forget_password_otp;

class ForgetPasswordOtpSentText extends StatelessWidget {
  final String enteredEmail;
  const ForgetPasswordOtpSentText({super.key, required this.enteredEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: context.colorScheme.secondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.theOtpHasSentText,
                  style: context.textTheme.bodySmall),
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
