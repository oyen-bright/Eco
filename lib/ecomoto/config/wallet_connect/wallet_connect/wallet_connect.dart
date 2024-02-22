library wallet_connect_;

import 'dart:developer';
import 'dart:io';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

part 'wallet_connect_chains.dart';
part 'wallet_connect_helpers.dart';

/// A class representing the configuration for WalletConnect integration.
///
/// This class provides configuration parameters and methods for integrating
/// WalletConnect functionality into a Dart application. WalletConnect allows
/// users to connect their wallets to decentralized applications, enabling secure
/// and convenient transaction signing.
///
/// ## Features
/// - Initialization of WalletConnect client instance.
/// - Session management, including restoration and termination.
/// - Handling different wallet types and their associated deep links.
/// - Integration with Web3App for Ethereum-related functionality.
///
/// ## Usage
/// To use this class, initialize it using the `init` method, which sets up the
/// WalletConnect client instance. The class also provides methods for session
/// management, such as restoring a session and terminating it.
///
/// WalletConnectConfig also includes methods for interacting with Web3App,
/// such as requesting transaction signatures and sending transactions.
///
/// Example:
/// ```dart
/// await WalletConnectConfig.init();
/// final result = await WalletConnectConfig.personalSign(address: '0x123', data: 'Hello, World!');
/// print('Signature: $result');
/// ```
///
/// **Note:** Ensure to call `init` before using other methods to initialize the
/// WalletConnect client properly.
class WalletConnect {
  WalletConnect._();

  /// The project ID for WalletConnect obtained from EnvironmentConfig.
  static final String projectId = AppEnvironment.walletConnectID;

  /// The active session data.
  static SessionData? session;

  /// The WalletConnect client instance.
  static late final Web3App? wcClient;

  /// The authentication client for WalletConnect.
  static late final AuthClient wcAuthClint;

  /// The current wallet provider type.
  static WalletType? currentWalletProvider;

  /// The response from a WalletConnect connection.
  static late ConnectResponse? connectResponse;

  /// Details of different wallet types including deep links and redirect links.

  /// Get the active WalletConnect client.
  static Web3App get client {
    if (wcClient == null) {
      throw Exception(
          'Web3App client has not been initialized. Call initClient first.');
    }
    return wcClient!;
  }

  /// Get the chain ID from the active session.
  static String get chainId {
    if (session != null) {
      return NamespaceUtils.getChainFromAccount(
        session?.namespaces.values.first.accounts.first ?? "",
      );
    }
    return "";
  }

  /// Get the topic of the active session.
  static String get topic {
    if (session != null) {
      return session!.topic;
    }
    return "";
  }

  /// Get the wallet address from the active session.
  static String? get walletAddress {
    try {
      if (session != null) {
        final String address = NamespaceUtils.getAccount(
          session!.namespaces.values.first.accounts.first,
        );
        return address;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get the active session data.
  static SessionData? get sessionData {
    return session;
  }

  /// Initialize the WalletConnect client.
  static Future init() async {
    try {
      wcClient = await Web3App.createInstance(
        relayUrl: 'wss://relay.walletconnect.com',
        projectId: projectId,
        metadata: const PairingMetadata(
          name: AppConstants.appName,
          description: AppConstants.appDescription,
          url: AppConstants.appDomain,
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );

      log("Instance Created", name: "Wallet Connect");
      _restoreSession();
    } catch (err, stackTrace) {
      log("CreateInstance error $stackTrace", name: "Wallet Connect");
    }
  }

  /// Restore the active session.
  static void _restoreSession() {
    try {
      final activeSession = wcClient?.getActiveSessions();

      if (activeSession != null && activeSession.isNotEmpty) {
        session = activeSession.values.first;
        currentWalletProvider = WalletConnectHelpers.geWalletType(session);

        log("Session restored", name: "Wallet connect");
      }
    } catch (e) {
      return;
    }
  }

  // /// Kill the active session.
  // static Future<(String? error, bool isKilled)> killSession(
  //     SessionData sessionData) async {
  //   try {
  //     await wcClient?.disconnectSession(
  //         topic: sessionData.topic,
  //         reason: Errors.getSdkError(Errors.USER_DISCONNECTED));

  //     log("session killed", name: "Wallet Connect");
  //     return (null, true);
  //   } catch (err, stackTrace) {
  //     log("killing wallet error $err $stackTrace", name: "Wallet Connect");

  //     rethrow;
  //   }
  // }
}
