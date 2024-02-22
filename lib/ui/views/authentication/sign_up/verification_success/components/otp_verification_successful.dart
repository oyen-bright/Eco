part of verification_success;

class OtpVerificationSuccessful extends StatelessWidget {
  const OtpVerificationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Image.asset(
            AppImages.otpVerified,
          ),
        ),
        Text(
          Strings.verificationSuccessfulText,
          style: context.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
