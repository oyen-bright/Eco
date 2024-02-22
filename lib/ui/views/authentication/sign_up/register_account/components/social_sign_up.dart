part of register_account;

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: AppSizes.size1,
              color: context.colorScheme.onBackground,
              width: AppSizes.size100,
            ),
            Text(
              Strings.orText,
              style: context.textTheme.titleSmall,
            ),
            Container(
              height: AppSizes.size1,
              color: context.colorScheme.onBackground,
              width: AppSizes.size100,
            ),
          ],
        ),
        const SizedBox(
          height: AppSizes.size20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButtons(context, AppImages.googleSignUpImage),
            _buildSocialButtons(context, AppImages.appleSignUpImage),
            _buildSocialButtons(context, AppImages.facebookSignUpImage),
          ],
        )
      ],
    );
  }
}

Widget _buildSocialButtons(BuildContext context, String imagePath) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppSizes.size100, AppSizes.size40),
        padding: AppConstants.contentPadding,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      onPressed: () {
        //TODO;social buttons signup
      },
      child: SizedBox(
          height: AppSizes.size20,
          width: AppSizes.size20,
          child: Image.asset(imagePath)));
}
