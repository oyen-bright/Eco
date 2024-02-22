part of forget_password;

class FormHeaderImage extends StatelessWidget {
  const FormHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.forgetPasswordBannerImage,
        height: AppSizes.size120 + AppSizes.size60,
      ),
    );
  }
}
