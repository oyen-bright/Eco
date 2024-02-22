import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/wallet_connect/wallet_connect.dart';
import 'package:emr_005/ecomoto/config/wallet_connect/wallet_connect_modal/wallet_connect_modal_config.dart';
import 'package:emr_005/ecomoto/config/wallet_manager/waller_manager.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:hex/hex.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';

class WalletService {
  WalletService();

  W3MService get walletConnectModalService => WalletConnectModal.service;

  Future<({String? error, String? accountAddress})> connectWallet(
      WalletType walletType) async {
    try {
      WalletConnect.connectResponse = await WalletConnect.wcClient?.connect(
          requiredNamespaces: WalletConnectChainConfig.requiredNamespaces);
      await WalletConnectHelpers.goToWallet(
          WalletConnect.connectResponse?.uri, walletType);

      WalletConnect.session =
          (await WalletConnect.connectResponse?.session.future);
      WalletConnect.currentWalletProvider = walletType;

      debugPrint("SessionData ----> ${WalletConnect.session.toString()}");

      return (error: null, accountAddress: WalletConnect.walletAddress);
    } on JsonRpcError catch (e) {
      throw e.message ?? e;
    } catch (err, s) {
      debugPrint("error connecting wallet -----> $err, $s");

      return (error: err.toString(), accountAddress: null);
    }
  }

  Future<({String? error})> disconnectWallet() async {
    try {
      final currentSession = WalletConnect.session;
      if (currentSession != null) {
        await WalletConnect.client.disconnectSession(
            topic: currentSession.topic,
            reason: Errors.getSdkError(Errors.USER_DISCONNECTED));
      }

      return (error: null);
    } on JsonRpcError catch (e) {
      throw e.message ?? e;
    } catch (e) {
      return (error: e.toString());
    }
  }

  ({WalletType walletType, String walletAddress})? get connectedWalletDetails {
    if (WalletConnect.session != null) {
      return (
        walletType: WalletConnect.currentWalletProvider!,
        walletAddress: WalletConnect.walletAddress!
      );
    }
    return null;
  }

  Future<({String? walletAddress, UserWalletType? walletType})?>
      getAvailableWallet() async {
    final walletService = WalletConnectModal.service;
    final walletAddress = WalletConnectModal.walletAddress;

    if (await WalletManager.isAvailable) {
      final generatedWallet = await WalletManager.details;

      return (
        walletAddress: generatedWallet?.publicKey,
        walletType: UserWalletType.generatedWallet
      );
    }

    if (walletService.isConnected && walletAddress != null) {
      return (
        walletAddress: walletAddress,
        walletType: UserWalletType.walletProvider
      );
    }
    return null;
  }

  Future<bool> get hasGeneratedWallet async =>
      (await LocalStorage.generatedWallet) != null;

  Future<({String? error, Map<String, dynamic>? data})> generateWallet() async {
    try {
      final mnemonic = bip39.generateMnemonic();
      final mnemonicSeed = bip39.mnemonicToSeed(mnemonic);
      final masterKey = await ED25519_HD_KEY.getMasterKeyFromSeed(mnemonicSeed);
      final privateKey = HEX.encode(masterKey.key);
      final publicKey = EthPrivateKey.fromHex(privateKey).address;

      final walletDetails = {
        "mnemonic": mnemonic,
        "privateKey": privateKey,
        "publicKey": EthereumAddress.fromHex(publicKey.hex).hexEip55,
      };
      await LocalStorage.saveGeneratedWallet(
        mnemonic: walletDetails['mnemonic']!,
        privateKey: walletDetails['privateKey']!,
        publicKey: walletDetails['publicKey']!,
      );

      return (
        error: null,
        data: {
          "mnemonic": walletDetails['mnemonic']!,
          "privateKey": walletDetails['privateKey']!,
          "publicKey": walletDetails['publicKey']!,
        }
      );
    } catch (e) {
      return (error: e.toString(), data: null);
    }
  }
}
