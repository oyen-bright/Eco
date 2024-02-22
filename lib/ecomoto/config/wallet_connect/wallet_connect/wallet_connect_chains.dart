part of wallet_connect_;

class WalletConnectChainConfig {
  static Map<String, RequiredNamespace>? get requiredNamespaces => {
        'eip155': const RequiredNamespace(chains: [
          // 'eip155:1'
          'eip155:80001'
        ], methods: [
          'personal_sign',
          'eth_sign',
          'eth_sendTransaction',
          'eth_signTypedData',
        ], events: [
          'eth_sendTransaction',
          "chainChanged",
          "accountsChanged"
        ]),
      };

  static AuthRequestParams get authRequestParams => AuthRequestParams(
        domain: 'walletconnect.org',
        aud: 'https://walletconnect.org/login',
        chainId: 'eip155:1',
        statement: 'Sign in with your wallet!',
      );
}
