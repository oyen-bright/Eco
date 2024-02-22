// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletState _$WalletStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'noWallet':
      return NoWallet.fromJson(json);
    case 'hasWallet':
      return HasWallet.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WalletState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$WalletState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noWallet,
    required TResult Function(WalletType walletType, String walletAddress)
        hasWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noWallet,
    TResult? Function(WalletType walletType, String walletAddress)? hasWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noWallet,
    TResult Function(WalletType walletType, String walletAddress)? hasWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoWallet value) noWallet,
    required TResult Function(HasWallet value) hasWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoWallet value)? noWallet,
    TResult? Function(HasWallet value)? hasWallet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoWallet value)? noWallet,
    TResult Function(HasWallet value)? hasWallet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NoWalletImplCopyWith<$Res> {
  factory _$$NoWalletImplCopyWith(
          _$NoWalletImpl value, $Res Function(_$NoWalletImpl) then) =
      __$$NoWalletImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoWalletImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$NoWalletImpl>
    implements _$$NoWalletImplCopyWith<$Res> {
  __$$NoWalletImplCopyWithImpl(
      _$NoWalletImpl _value, $Res Function(_$NoWalletImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NoWalletImpl extends NoWallet {
  const _$NoWalletImpl({final String? $type})
      : $type = $type ?? 'noWallet',
        super._();

  factory _$NoWalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoWalletImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WalletState.noWallet()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoWalletImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noWallet,
    required TResult Function(WalletType walletType, String walletAddress)
        hasWallet,
  }) {
    return noWallet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noWallet,
    TResult? Function(WalletType walletType, String walletAddress)? hasWallet,
  }) {
    return noWallet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noWallet,
    TResult Function(WalletType walletType, String walletAddress)? hasWallet,
    required TResult orElse(),
  }) {
    if (noWallet != null) {
      return noWallet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoWallet value) noWallet,
    required TResult Function(HasWallet value) hasWallet,
  }) {
    return noWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoWallet value)? noWallet,
    TResult? Function(HasWallet value)? hasWallet,
  }) {
    return noWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoWallet value)? noWallet,
    TResult Function(HasWallet value)? hasWallet,
    required TResult orElse(),
  }) {
    if (noWallet != null) {
      return noWallet(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NoWalletImplToJson(
      this,
    );
  }
}

abstract class NoWallet extends WalletState {
  const factory NoWallet() = _$NoWalletImpl;
  const NoWallet._() : super._();

  factory NoWallet.fromJson(Map<String, dynamic> json) =
      _$NoWalletImpl.fromJson;
}

/// @nodoc
abstract class _$$HasWalletImplCopyWith<$Res> {
  factory _$$HasWalletImplCopyWith(
          _$HasWalletImpl value, $Res Function(_$HasWalletImpl) then) =
      __$$HasWalletImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WalletType walletType, String walletAddress});
}

/// @nodoc
class __$$HasWalletImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$HasWalletImpl>
    implements _$$HasWalletImplCopyWith<$Res> {
  __$$HasWalletImplCopyWithImpl(
      _$HasWalletImpl _value, $Res Function(_$HasWalletImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletType = null,
    Object? walletAddress = null,
  }) {
    return _then(_$HasWalletImpl(
      walletType: null == walletType
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as WalletType,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HasWalletImpl extends HasWallet {
  const _$HasWalletImpl(
      {required this.walletType,
      required this.walletAddress,
      final String? $type})
      : $type = $type ?? 'hasWallet',
        super._();

  factory _$HasWalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$HasWalletImplFromJson(json);

  @override
  final WalletType walletType;
  @override
  final String walletAddress;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WalletState.hasWallet(walletType: $walletType, walletAddress: $walletAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HasWalletImpl &&
            (identical(other.walletType, walletType) ||
                other.walletType == walletType) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, walletType, walletAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HasWalletImplCopyWith<_$HasWalletImpl> get copyWith =>
      __$$HasWalletImplCopyWithImpl<_$HasWalletImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noWallet,
    required TResult Function(WalletType walletType, String walletAddress)
        hasWallet,
  }) {
    return hasWallet(walletType, walletAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noWallet,
    TResult? Function(WalletType walletType, String walletAddress)? hasWallet,
  }) {
    return hasWallet?.call(walletType, walletAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noWallet,
    TResult Function(WalletType walletType, String walletAddress)? hasWallet,
    required TResult orElse(),
  }) {
    if (hasWallet != null) {
      return hasWallet(walletType, walletAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoWallet value) noWallet,
    required TResult Function(HasWallet value) hasWallet,
  }) {
    return hasWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoWallet value)? noWallet,
    TResult? Function(HasWallet value)? hasWallet,
  }) {
    return hasWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoWallet value)? noWallet,
    TResult Function(HasWallet value)? hasWallet,
    required TResult orElse(),
  }) {
    if (hasWallet != null) {
      return hasWallet(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HasWalletImplToJson(
      this,
    );
  }
}

abstract class HasWallet extends WalletState {
  const factory HasWallet(
      {required final WalletType walletType,
      required final String walletAddress}) = _$HasWalletImpl;
  const HasWallet._() : super._();

  factory HasWallet.fromJson(Map<String, dynamic> json) =
      _$HasWalletImpl.fromJson;

  WalletType get walletType;
  String get walletAddress;
  @JsonKey(ignore: true)
  _$$HasWalletImplCopyWith<_$HasWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
