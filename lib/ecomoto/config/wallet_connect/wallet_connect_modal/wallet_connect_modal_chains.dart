part of wallet_connect_modal;

class WalletConnectModalChainConfig {
  static W3MChainInfo get _chainInfo => W3MChainPresets.chains['137']!;

  static Map<String, W3MNamespace> get optionalNamespaces => {
        'eip155': const W3MNamespace(
          chains: ['eip155:80001'],
          methods: EthConstants.allMethods,
          events: EthConstants.allEvents,
        ),
      };

  static W3MChainInfo get customChain => W3MChainInfo(
        chainName: 'Polygon Testnet',
        namespace: 'eip155:80001',
        chainId: '80001',
        chainIcon: _chainInfo.chainIcon,
        tokenName: 'MATIC',
        // namespace: {
        //   'eip155': const RequiredNamespace(
        //     methods: EthConstants.allMethods,
        //     chains: ['eip155:80001'],
        //     events: EthConstants.allEvents,
        //   ),
        // },
        rpcUrl:
            'https://polygon-mumbai.g.alchemy.com/v2/rU-nyBnC6PbfXZOYWceIoD3m3m4c9vI-',
        blockExplorer: W3MBlockExplorer(
          name: 'PolygonScan (Mumbai)',
          url: 'https://mumbai.polygonscan.com',
        ),
      );
}
