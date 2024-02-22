part of complete_profile;

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            Strings.almostThereText,
            style: AppTextStyles.authSectionHeaderTextStyle,
          ),
          Text(
            Strings.getStartedText,
            style: context.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
