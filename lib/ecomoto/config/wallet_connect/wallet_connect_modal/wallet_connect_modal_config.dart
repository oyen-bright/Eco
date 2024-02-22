library wallet_connect_modal;

import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../../../config/app_environment.dart';

part 'wallet_connect_modal_chains.dart';
part 'wallet_connect_modal_listeners.dart';

class WalletConnectModal {
  static late W3MService _w3mService;
  static final String _projectId = AppEnvironment.walletConnectID;

  static W3MService get service => _w3mService;
  static final Set<String> _includedWalletIds = {
    'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
    '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // Trust
  };

  static String? get walletAddress {
    try {
      if (_w3mService.session != null) {
        final String address = NamespaceUtils.getAccount(
          _w3mService.session!.namespaces.values.first.accounts.first,
        );
        return address;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static String get topic {
    if (_w3mService.session != null) {
      return service.session!.topic;
    }
    return "";
  }

  static String get chainId {
    if (_w3mService.session != null) {
      return NamespaceUtils.getChainFromAccount(
        service.session?.namespaces.values.first.accounts.first ?? "",
      );
    }
    return "";
  }

  static Future<void> init() async {
    _w3mService = W3MService(
      projectId: _projectId,
      logLevel: LogLevel.error,
      includedWalletIds: _includedWalletIds,
      requiredNamespaces: WalletConnectModalChainConfig.optionalNamespaces,
      optionalNamespaces: WalletConnectModalChainConfig.optionalNamespaces,
      metadata: const PairingMetadata(
        name: AppConstants.appName,
        description: AppConstants.appDescription,
        url: AppConstants.appDomain,
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
        redirect: Redirect(
          native: 'ecomoto://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    W3MChainPresets.chains.putIfAbsent(
        WalletConnectModalChainConfig.customChain.chainId,
        () => WalletConnectModalChainConfig.customChain);
//TODO: await and throw error on init
//TODO: show uset the prompt wallet not available at the moment please restart tje app
    await _w3mService.init();
    log("Instance Created", name: "Wallet Connect Model");

    _w3mService.selectChain(WalletConnectModalChainConfig.customChain);
    WalletConnectModalListenerConfig.subscribeToSessionEvents();
  }

  static void dispose() {
    WalletConnectModalListenerConfig.dispose();
  }
}
