part of register_account;

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AutoSizeText(
            Strings.signUpText,
            style: AppTextStyles.authSectionHeaderTextStyle,
            maxLines: 2,
          ),
          AutoSizeText(
            Strings.signUpSubText,
            style: context.textTheme.bodyMedium,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
