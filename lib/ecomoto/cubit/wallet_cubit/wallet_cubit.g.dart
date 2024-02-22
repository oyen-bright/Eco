// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoWalletImpl _$$NoWalletImplFromJson(Map<String, dynamic> json) =>
    _$NoWalletImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NoWalletImplToJson(_$NoWalletImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$HasWalletImpl _$$HasWalletImplFromJson(Map<String, dynamic> json) =>
    _$HasWalletImpl(
      walletType: $enumDecode(_$WalletTypeEnumMap, json['walletType']),
      walletAddress: json['walletAddress'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$HasWalletImplToJson(_$HasWalletImpl instance) =>
    <String, dynamic>{
      'walletType': _$WalletTypeEnumMap[instance.walletType]!,
      'walletAddress': instance.walletAddress,
      'runtimeType': instance.$type,
    };

const _$WalletTypeEnumMap = {
  WalletType.metamask: 'metamask',
  WalletType.trustWallet: 'trustWallet',
  WalletType.rainbowWallet: 'rainbowWallet',
  WalletType.coinbase: 'coinbase',
};
