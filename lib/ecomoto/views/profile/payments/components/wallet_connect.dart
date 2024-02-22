import 'package:emr_005/ecomoto/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:emr_005/ecomoto/mixins/wallet_mixin.dart';
import 'package:emr_005/ecomoto/views/profile/payments/components/no_methods_saved.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/cards/wallet_account_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/strings.dart';

class WalletConnectView extends StatelessWidget with WalletUtils {
  const WalletConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: AppSizes.size20,
            ),
            if (state is NoWallet) ...[
              _buildConnectWalletButton(context),
              const SizedBox(
                height: AppSizes.size20,
              ),
              const NoMethodSaved(),
            ] else if (state is HasWallet) ...[
              _buildDisconnectButton(context, state.walletAddress),
            ],
          ],
        );
      },
    );
  }

  Widget _buildConnectWalletButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: AppElevatedButton(
        backgroundColor: context.colorScheme.onBackground,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size10),
        onPressed: () => connectWallet(context),
        title: Strings.connectYourWallet,
      ),
    );
  }

  Widget _buildDisconnectButton(BuildContext context, String walletAddress) {
    return GestureDetector(
      onTap: () => context.read<WalletCubit>().disconnectWallet(),
      child: WalletAccountDetails(walletAddress: walletAddress),
    );
  }
}
