import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/services/ecomoto/wallet_service.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

part 'wallet_cubit.freezed.dart';
part 'wallet_cubit.g.dart';
part 'wallet_state.dart';

class WalletCubit extends HydratedCubit<WalletState> {
  final WalletService walletService;

  WalletCubit(this.walletService) : super(const WalletState.noWallet()) {
    if (!AppEnvironment.useWalletConnectModal) {
      _initializeNonModalWallet();
    } else {
      _subscribeToSessionEvents();
    }
  }

  void _initializeNonModalWallet() {
    final connectedWalletDetails = walletService.connectedWalletDetails;
    if (connectedWalletDetails == null) {
      emit(const WalletState.noWallet());
    } else {
      emit(WalletState.hasWallet(
        walletAddress: connectedWalletDetails.walletAddress,
        walletType: connectedWalletDetails.walletType,
      ));
    }
  }

  Future<({String? error, String? walletAddress})> connectWallet({
    required WalletType walletType,
  }) async {
    final response = await walletService.connectWallet(walletType);

    if (response.error != null) {
      return (error: response.error, walletAddress: response.accountAddress);
    } else {
      emit(WalletState.hasWallet(
        walletAddress: response.accountAddress!,
        walletType: walletType,
      ));
      return (error: null, walletAddress: response.accountAddress);
    }
  }

  Future<String?> disconnectWallet() async {
    final response = await walletService.disconnectWallet();

    if (response.error != null) {
      return response.error;
    } else {
      emit(const WalletState.noWallet());
    }

    return null;
  }

  W3MService get modalService => walletService.walletConnectModalService;

  void _subscribeToSessionEvents() {
    modalService.web3App?.onSessionConnect.subscribe(_onSessionConnect);
    modalService.web3App?.onSessionDelete.subscribe(_onSessionDelete);
  }

  void _onSessionConnect(SessionConnect? sessionConnect) {
    if (sessionConnect != null) {
      final walletAddress = NamespaceUtils.getAccount(
        sessionConnect.session.namespaces.values.first.accounts.first,
      );

      final walletType = _getWalletType(sessionConnect.session);
      emit(WalletState.hasWallet(
        walletAddress: walletAddress,
        walletType: walletType ?? WalletType.metamask,
      ));
    }
  }

  void _onSessionDelete(SessionDelete? sessionDelete) {
    if (sessionDelete != null && sessionDelete.id == null) {
      emit(const NoWallet());
    }
  }

  static WalletType? _getWalletType(SessionData? sessionData) {
    final peerWalletName = sessionData?.peer.metadata.name.toLowerCase() ?? "";

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

  @override
  WalletState fromJson(Map<String, dynamic> json) {
    return WalletState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    modalService.web3App?.onSessionConnect.unsubscribe(_onSessionConnect);
    modalService.web3App?.onSessionDelete.unsubscribe(_onSessionDelete);
    return super.close();
  }
}
