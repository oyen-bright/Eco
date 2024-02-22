part of create_password;

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.createNewPasswordText,
            style: context.textTheme.headlineSmall,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.enterNewPasswordText,
            style: context.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
