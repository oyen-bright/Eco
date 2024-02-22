part of '../login_view.dart';

class NewToWeb3 extends StatelessWidget {
  const NewToWeb3({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.notMemberText,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () => AppRouter.router.pushReplacement(AppRoutes.signUp),
          child: Text(
            Strings.signUpHereText,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.vibrantColor,
            ),
          ),
        ),
      ],
    );
  }
}
