part of forget_password;

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.forgotPasswordText,
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child:
              Text(Strings.enterEmailText, style: context.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
