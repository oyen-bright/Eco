part of forget_password;

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.rememberThePasswordText,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          width: AppSizes.size4,
        ),
        GestureDetector(
          onTap: () => AppRouter.router.pushReplacement(AppRoutes.login),
          child: Text(
            Strings.loginText,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.vibrantColor,
            ),
          ),
        ),
      ],
    );
  }
}
