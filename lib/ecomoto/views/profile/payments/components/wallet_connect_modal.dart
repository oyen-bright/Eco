import 'package:emr_005/ecomoto/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/themes/wallet_connect_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'no_methods_saved.dart';

class WalletConnectModalView extends StatelessWidget {
  const WalletConnectModalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final walletConnectModalService =
            context.read<WalletCubit>().modalService;

        return Column(
          children: [
            const SizedBox(
              height: AppSizes.size20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Web3ModalTheme(
                themeData: Web3ModalTheme.of(context).themeData?.copyWith(
                      lightColors: walletConnectButtonTheme.lightColors,
                    ),
                child:
                    W3MConnectWalletButton(service: walletConnectModalService),
              ),
            ),
            const SizedBox(
              height: AppSizes.size20,
            ),
            if (state is HasWallet) ...{
              W3MAccountButton(service: walletConnectModalService)
            } else if (state is NoWallet) ...{
              const NoMethodSaved(),
            }
          ],
        );
      },
    );
  }
}
