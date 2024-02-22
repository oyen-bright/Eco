part of wallet_connect_;

class WalletConnectHelpers {
  static Map<WalletType, dynamic> get walletDetails => {
        WalletType.metamask: {
          "deepLink": "metamask://wc?uri=",
          "redirectLink": {
            "ios": "https://apps.apple.com/us/app/metamask/id1533182310",
            "android":
                "https://play.google.com/store/apps/details?id=io.metamask"
          }
        },
        WalletType.trustWallet: {
          "deepLink": "trust://wc?uri=",
          "redirectLink": {
            "ios":
                "https://apps.apple.com/us/app/trust-ethereum-wallet/id1288339409",
            "android":
                "https://play.google.com/store/apps/details?id=com.wallet.crypto.trustapp"
          }
        },
        WalletType.rainbowWallet: {
          "deepLink": "rainbow://wc?uri=",
          "redirectLink": {
            "ios":
                "https://apps.apple.com/us/app/rainbow-bitcoin-ethereum-wallet/id1287292762",
            "android":
                "https://play.google.com/store/apps/details?id=com.rainbow.me"
          }
        },
        WalletType.coinbase: {
          "deepLink": "coinbase://wc?uri=",
          "redirectLink": {
            "ios": "https://apps.apple.com/us/app/coinbase-wallet/id1278383455",
            "android": "https://play.google.com/store/apps/details?id=org.toshi"
          }
        },
      };

  /// Get the wallet type from the active session data.

  static WalletType? geWalletType(SessionData? sessionData) {
    String peerWalletName = sessionData?.peer.metadata.name.toLowerCase() ?? "";

    if (peerWalletName.contains("metamask")) {
      return WalletType.metamask;
    } else if (peerWalletName.contains("trust")) {
      return WalletType.trustWallet;
    } else if (peerWalletName.contains("rainbow")) {
      return WalletType.rainbowWallet;
    } else if (peerWalletName.contains("coinbase")) {
      return WalletType.coinbase;
    } else {
      return null;
    }
  }

  /// Format the native URL for deep linking.
  static Uri? _formatNativeUrl(String wcUri, WalletType walletType) {
    String safeAppUrl = walletDetails[walletType]["deepLink"] ?? "";
    String? deepLink = walletDetails[walletType]["deepLink"];

    if (deepLink != null && deepLink.isNotEmpty) {
      if (!safeAppUrl.contains('://')) {
        safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
        safeAppUrl = '$safeAppUrl://';
      }
    }

    String encodedWcUrl = Uri.encodeComponent(wcUri);
    log('Encoded WC URL: $encodedWcUrl');
    return Uri.parse('$safeAppUrl$encodedWcUrl');
  }

  /// Display the WalletConnect URI.
  static Future<bool> goToWallet(Uri? uri, WalletType walletType) async {
    final link = _formatNativeUrl(uri.toString(), walletType);

    final redirectURL =
        walletDetails[walletType]['redirectLink'][Platform.operatingSystem];
    var url = link.toString();

    if (!await canLaunchUrlString(url)) {
      log('Redirect URL: $redirectURL');

      return await launchUrlString(redirectURL,
          mode: LaunchMode.externalNonBrowserApplication);
    }
    log('Lunch URL: $url');

    return await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
