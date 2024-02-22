part of '../login_view.dart';

class ChangeLoginMethodButton extends StatelessWidget {
  final bool isLoginWithWallet;
  final void Function()? onPressed;

  const ChangeLoginMethodButton(
      {super.key, required this.isLoginWithWallet, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        isLoginWithWallet ? Strings.loginWithPassword : Strings.loginWithWallet,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
          // color: AppColors.darkGreyColor,
        ),
      ),
    );
  }
}
