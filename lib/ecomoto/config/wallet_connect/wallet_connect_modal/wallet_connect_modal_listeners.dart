part of wallet_connect_modal;

class WalletConnectModalListenerConfig {
  static final _service = WalletConnectModal._w3mService;

  static void subscribeToSessionEvents() {
    _service.web3App?.onSessionEvent.subscribe(onSessionEvent);
    _service.web3App?.onSessionConnect.subscribe(_onSessionConnect);
    _service.web3App?.onSessionDelete.subscribe(_onSessionDelete);
  }

  static void onWalletConnectError() {
    //TODO: implemnt showing the error on connect to user escpecially when the chain id is not available on users wallet
    _service.onWalletConnectionError.subscribe((args) {});
  }

  static void onSessionEvent(SessionEvent? args) {
    log('[] _onSessionEvent $args');
    // Your logic for handling session events
  }

  static void _onSessionConnect(SessionConnect? args) {}

  static void _onSessionDelete(SessionDelete? args) {}

  static void dispose() {
    _service.web3App?.onSessionEvent.unsubscribe(onSessionEvent);
    _service.web3App?.onSessionConnect.unsubscribe(_onSessionConnect);
    _service.web3App?.onSessionDelete.unsubscribe(_onSessionDelete);
  }
}
