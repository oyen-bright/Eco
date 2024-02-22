import 'package:emr_005/ecomoto/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:emr_005/ecomoto/views/profile/payments/components/add_wallet.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin WalletUtils {
  static const String _selectWalletTypeBottomSheetTitle = "Connect Account";
  static const String _connectionWalletBottomSheetTitle = "Connecting";
  static const String _errorConnectionWalletBottomSheetTitle =
      "Connection Error";
  static const String _accountDetailsWalletBottomSheetTitle = "Account Details";

  static final GlobalKey<ConnectingWalletState> connectingWalletStateKey =
      GlobalKey();

  Future<String?> _connectToWalletProvider(
    BuildContext context,
    WalletType selectedWallet,
  ) async {
    final connectingWallet = ConnectingWallet(
      walletType: selectedWallet,
      key: connectingWalletStateKey,
    );
    connectingWallet.asAddWalletBottomSheet(
      context,
      title: _connectionWalletBottomSheetTitle,
      isDismissible: false,
    );

    final response = await context
        .read<WalletCubit>()
        .connectWallet(walletType: selectedWallet);

    connectingWalletStateKey.currentState?.close();

    if (response.error != null) {
      if (context.mounted) {
        final retryConnection = await ConnectionError(
          walletType: selectedWallet,
          errorMessage: response.error,
        ).asAddWalletBottomSheet<bool?>(
          context,
          title: _errorConnectionWalletBottomSheetTitle,
        );

        if (retryConnection == true && context.mounted) {
          return await _connectToWalletProvider(context, selectedWallet);
        }
      }
    } else {
      return response.walletAddress!;
    }
    return null;
  }

  void connectWallet(BuildContext context) async {
    final selectedWallet =
        await const SelectWallet().asAddWalletBottomSheet<WalletType?>(
      context,
      title: _selectWalletTypeBottomSheetTitle,
    );

    if (selectedWallet != null && context.mounted) {
      final walletDetails =
          await _connectToWalletProvider(context, selectedWallet);

      if (walletDetails != null && context.mounted) {
        AccountDetails(
          walletAddress: walletDetails,
          walletType: selectedWallet,
        ).asAddWalletBottomSheet(context,
            title: _accountDetailsWalletBottomSheetTitle);
      }
    }
  }

  String formatAddress(String address) {
    if (address.length > 10) {
      return '${address.substring(0, 10)}....${address.substring(address.length - 8)}';
    } else {
      return address;
    }
  }
}
