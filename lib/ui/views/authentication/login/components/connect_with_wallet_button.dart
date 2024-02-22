part of '../login_view.dart';

class GenerateWalletButton extends StatelessWidget {
  const GenerateWalletButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void continueWithWallet() async {
      context.read<AuthCubit>().authenticateUserWithWallet(context: context);
    }

    Future<bool> onGenerateWallet() async {
      return context
          .read<UserCubit>()
          .generateWallet(forceGenerateWallet: false)
          .then((res) async {
        if (res.hasWalletAlready) {
          context.showSnackBar(Strings.alreadyHasWalletError);
          return false;
        }

        if (res.error != null || res.walletDetails == null) {
          context.showSnackBar(res.error, BarType.error);
          return false;
        }

        await (WalletDetails(walletDetails: res.walletDetails!)
            .asBottomSheet(context, bottomSafeArea: false));
        return true;
      });
    }

    return TextButton(
      onPressed: () async {
        onGenerateWallet().then((value) => value ? continueWithWallet() : null);
      },
      child: Text(
        Strings.connectWithWalletText,
        style: context.textTheme.titleMedium?.copyWith(
            // color: AppColors.darkGreyColor,
            ),
      ),
    );
  }
}
