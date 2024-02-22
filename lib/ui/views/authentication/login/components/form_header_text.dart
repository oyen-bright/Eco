part of '../login_view.dart';

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        Strings.signInText,
        style: AppTextStyles.authSectionHeaderTextStyle,
      ),
    );
  }
}
