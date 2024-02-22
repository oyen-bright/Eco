part of forget_password_otp;

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          Strings.otpSentSuccess,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ));
  }
}
