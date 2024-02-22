part of 'wallet_cubit.dart';

@freezed
class WalletState with _$WalletState {
  const WalletState._();
  const factory WalletState.noWallet() = NoWallet;
  const factory WalletState.hasWallet({
    required WalletType walletType,
    required String walletAddress,
  }) = HasWallet;

  String? get walletAddress {
    return maybeMap(
      hasWallet: (walletState) => walletState.walletAddress,
      orElse: () => null,
    );
  }

  factory WalletState.fromJson(Map<String, dynamic> json) =>
      _$WalletStateFromJson(json);
}
