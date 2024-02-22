import 'package:emr_005/ecomoto/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/cards/wallet_account_details.dart';
import 'package:emr_005/ui/components/loading_indicators/dot_indicator.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/strings.dart';

class SelectWallet extends StatelessWidget {
  const SelectWallet({
    Key? key,
  }) : super(key: key);

  static final walletProviders = [
    [WalletType.metamask, WalletType.trustWallet],
    [WalletType.rainbowWallet, WalletType.coinbase]
  ];

  static bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildEthereumListTile(),
          buildWalletExpansionTile(),
          const SizedBox(
            height: AppSizes.size20,
          ),
        ],
      ),
    );
  }

  Widget buildEthereumListTile() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      title: const Text(Strings.ethereumNetwork),
      leading: Image.asset(AppImages.ethereumIcon),
    );
  }

  Widget buildWalletExpansionTile() {
    return StatefulBuilder(builder: (context, setState) {
      return ExpansionTile(
        collapsedShape: const RoundedRectangleBorder(),
        shape: const RoundedRectangleBorder(),
        initiallyExpanded: true,
        textColor: context.colorScheme.onBackground,
        trailing: SelectWallet.isExpanded
            ? Image.asset(
                AppImages.arrowUpIcon,
                color: AppColors.darkGreyColor,
              )
            : Image.asset(
                AppImages.arrowDownIcon,
                color: AppColors.darkGreyColor,
              ),
        onExpansionChanged: (bool expanding) =>
            setState(() => SelectWallet.isExpanded = expanding),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: const Text(
          Strings.selectWallet,
          style: TextStyle(fontSize: 17),
        ),
        children: buildWalletListTiles(context),
      );
    });
  }

  List<Widget> buildWalletListTiles(BuildContext context) {
    return SelectWallet.walletProviders.map((e) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: buildWalletListTile(context, e.first),
          ),
          Expanded(
            child: buildWalletListTile(context, e.last),
          ),
        ],
      );
    }).toList();
  }

  Widget buildWalletListTile(BuildContext context, WalletType walletType) {
    return ListTile(
      onTap: () => context.pop(walletType),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      title: Text(walletType.title),
      leading: Image.asset(
        walletType.image,
        height: AppSizes.size30,
        width: AppSizes.size30,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ConnectingWallet extends StatefulWidget {
  final WalletType walletType;

  const ConnectingWallet({Key? key, required this.walletType})
      : super(key: key);

  @override
  State<ConnectingWallet> createState() => ConnectingWalletState();
}

class ConnectingWalletState extends State<ConnectingWallet> {
  void close() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: AppSizes.size30,
          ),
          buildDotLoadingIndicator(),
          const SizedBox(
            height: AppSizes.size30,
          ),
          buildConnectingText(),
          const SizedBox(
            height: AppSizes.size10,
          ),
          buildConnectionInfoText(),
          const SizedBox(
            height: AppSizes.size20,
          ),
        ],
      ),
    );
  }

  Widget buildDotLoadingIndicator() {
    return const DotLoadingIndicator();
  }

  Widget buildConnectingText() {
    return const Text(
      Strings.connectingWallet,
      textAlign: TextAlign.center,
    );
  }

  Widget buildConnectionInfoText() {
    return Text(
      Strings.connectingWalletInfo
          .replaceAll('[walletType]', widget.walletType.title),
      textAlign: TextAlign.center,
    );
  }
}

class ConnectionError extends StatelessWidget {
  final WalletType walletType;
  final String? errorMessage;

  const ConnectionError({Key? key, required this.walletType, this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: AppSizes.size30,
          ),
          buildErrorIcon(),
          const SizedBox(
            height: AppSizes.size10,
          ),
          buildErrorText(context),
          const SizedBox(
            height: AppSizes.size10,
          ),
          buildErrorMessage(errorMessage),
          const SizedBox(
            height: AppSizes.size20,
          ),
          buildReconnectButton(context),
          const SizedBox(
            height: AppSizes.size20,
          ),
        ],
      ),
    );
  }

  Widget buildErrorIcon() {
    return Image.asset(
      AppImages.errorIcon,
      scale: 1.5,
    );
  }

  Widget buildErrorText(BuildContext context) {
    return Text(
      Strings.errorOccurred,
      textAlign: TextAlign.center,
      style:
          context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
    );
  }

  Widget buildErrorMessage(String? errorMessage) {
    return Text(
      errorMessage ?? Strings.walletNotConnected,
      textAlign: TextAlign.center,
    );
  }

  Widget buildReconnectButton(BuildContext context) {
    return AppElevatedButton(
      onPressed: () => context.pop(true),
      title: Strings.reconnect,
    );
  }
}

class AccountDetails extends StatelessWidget {
  final String walletAddress;
  final WalletType walletType;

  const AccountDetails(
      {Key? key, required this.walletAddress, required this.walletType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onWalletDisconnect() {
      context.read<WalletCubit>().disconnectWallet().then((response) {
        if (response != null) {
          context.showSnackBar(response, BarType.error);
        } else {
          context.showSnackBar(Strings.onWalletDisconnect);
          context.pop();
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: AppSizes.size30,
          ),
          WalletAccountDetails(
            walletAddress: walletAddress,
          ),
          const SizedBox(
            height: AppSizes.size20,
          ),
          Row(
            children: [
              Expanded(
                  child: Text("${Strings.connectedTo} ${walletType.title}")),
              AppElevatedButton(
                title: Strings.disconnect,
                onPressed: onWalletDisconnect,
                titleColor: AppColors.colorBlack,
                backgroundColor: AppColors.lightErrorColor,
                borderColor: AppColors.errorColor,
              )
            ],
          ),
          const SizedBox(
            height: AppSizes.size30,
          ),
        ],
      ),
    );
  }
}
