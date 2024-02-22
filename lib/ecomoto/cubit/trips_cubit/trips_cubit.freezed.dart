// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trips_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TripsState _$TripsStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _Initial.fromJson(json);
    case 'loading':
      return _Loading.fromJson(json);
    case 'loaded':
      return _Loaded.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TripsState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TripsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loading,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loaded,
    required TResult Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult? Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult Function(String errorMessage, List<Trip> active, List<Trip> history,
            List<Trip> booked)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripsStateCopyWith<$Res> {
  factory $TripsStateCopyWith(
          TripsState value, $Res Function(TripsState) then) =
      _$TripsStateCopyWithImpl<$Res, TripsState>;
}

/// @nodoc
class _$TripsStateCopyWithImpl<$Res, $Val extends TripsState>
    implements $TripsStateCopyWith<$Res> {
  _$TripsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TripsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InitialImpl extends _Initial {
  const _$InitialImpl({final String? $type})
      : $type = $type ?? 'initial',
        super._();

  factory _$InitialImpl.fromJson(Map<String, dynamic> json) =>
      _$$InitialImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TripsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loading,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loaded,
    required TResult Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)
        error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult? Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)?
        error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult Function(String errorMessage, List<Trip> active, List<Trip> history,
            List<Trip> booked)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitialImplToJson(
      this,
    );
  }
}

abstract class _Initial extends TripsState {
  const factory _Initial() = _$InitialImpl;
  const _Initial._() : super._();

  factory _Initial.fromJson(Map<String, dynamic> json) = _$InitialImpl.fromJson;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Trip> active, List<Trip> history, List<Trip> booked});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TripsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? history = null,
    Object? booked = null,
  }) {
    return _then(_$LoadingImpl(
      active: null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      booked: null == booked
          ? _value._booked
          : booked // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadingImpl extends _Loading {
  const _$LoadingImpl(
      {required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked,
      final String? $type})
      : _active = active,
        _history = history,
        _booked = booked,
        $type = $type ?? 'loading',
        super._();

  factory _$LoadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadingImplFromJson(json);

  final List<Trip> _active;
  @override
  List<Trip> get active {
    if (_active is EqualUnmodifiableListView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_active);
  }

  final List<Trip> _history;
  @override
  List<Trip> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<Trip> _booked;
  @override
  List<Trip> get booked {
    if (_booked is EqualUnmodifiableListView) return _booked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_booked);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TripsState.loading(active: $active, history: $history, booked: $booked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(other._active, _active) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other._booked, _booked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_active),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(_booked));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loading,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loaded,
    required TResult Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)
        error,
  }) {
    return loading(active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult? Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)?
        error,
  }) {
    return loading?.call(active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult Function(String errorMessage, List<Trip> active, List<Trip> history,
            List<Trip> booked)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(active, history, booked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadingImplToJson(
      this,
    );
  }
}

abstract class _Loading extends TripsState {
  const factory _Loading(
      {required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked}) = _$LoadingImpl;
  const _Loading._() : super._();

  factory _Loading.fromJson(Map<String, dynamic> json) = _$LoadingImpl.fromJson;

  List<Trip> get active;
  List<Trip> get history;
  List<Trip> get booked;
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Trip> active, List<Trip> history, List<Trip> booked});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$TripsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? active = null,
    Object? history = null,
    Object? booked = null,
  }) {
    return _then(_$LoadedImpl(
      active: null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      booked: null == booked
          ? _value._booked
          : booked // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadedImpl extends _Loaded {
  const _$LoadedImpl(
      {required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked,
      final String? $type})
      : _active = active,
        _history = history,
        _booked = booked,
        $type = $type ?? 'loaded',
        super._();

  factory _$LoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadedImplFromJson(json);

  final List<Trip> _active;
  @override
  List<Trip> get active {
    if (_active is EqualUnmodifiableListView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_active);
  }

  final List<Trip> _history;
  @override
  List<Trip> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<Trip> _booked;
  @override
  List<Trip> get booked {
    if (_booked is EqualUnmodifiableListView) return _booked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_booked);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TripsState.loaded(active: $active, history: $history, booked: $booked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._active, _active) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other._booked, _booked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_active),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(_booked));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loading,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loaded,
    required TResult Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)
        error,
  }) {
    return loaded(active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult? Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)?
        error,
  }) {
    return loaded?.call(active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult Function(String errorMessage, List<Trip> active, List<Trip> history,
            List<Trip> booked)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(active, history, booked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadedImplToJson(
      this,
    );
  }
}

abstract class _Loaded extends TripsState {
  const factory _Loaded(
      {required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked}) = _$LoadedImpl;
  const _Loaded._() : super._();

  factory _Loaded.fromJson(Map<String, dynamic> json) = _$LoadedImpl.fromJson;

  List<Trip> get active;
  List<Trip> get history;
  List<Trip> get booked;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String errorMessage,
      List<Trip> active,
      List<Trip> history,
      List<Trip> booked});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$TripsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? active = null,
    Object? history = null,
    Object? booked = null,
  }) {
    return _then(_$ErrorImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
      booked: null == booked
          ? _value._booked
          : booked // ignore: cast_nullable_to_non_nullable
              as List<Trip>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl extends _Error {
  const _$ErrorImpl(
      {required this.errorMessage,
      required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked,
      final String? $type})
      : _active = active,
        _history = history,
        _booked = booked,
        $type = $type ?? 'error',
        super._();

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String errorMessage;
  final List<Trip> _active;
  @override
  List<Trip> get active {
    if (_active is EqualUnmodifiableListView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_active);
  }

  final List<Trip> _history;
  @override
  List<Trip> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  final List<Trip> _booked;
  @override
  List<Trip> get booked {
    if (_booked is EqualUnmodifiableListView) return _booked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_booked);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TripsState.error(errorMessage: $errorMessage, active: $active, history: $history, booked: $booked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._active, _active) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other._booked, _booked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      errorMessage,
      const DeepCollectionEquality().hash(_active),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(_booked));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loading,
    required TResult Function(
            List<Trip> active, List<Trip> history, List<Trip> booked)
        loaded,
    required TResult Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)
        error,
  }) {
    return error(errorMessage, active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult? Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult? Function(String errorMessage, List<Trip> active,
            List<Trip> history, List<Trip> booked)?
        error,
  }) {
    return error?.call(errorMessage, active, history, booked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loading,
    TResult Function(List<Trip> active, List<Trip> history, List<Trip> booked)?
        loaded,
    TResult Function(String errorMessage, List<Trip> active, List<Trip> history,
            List<Trip> booked)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage, active, history, booked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error extends TripsState {
  const factory _Error(
      {required final String errorMessage,
      required final List<Trip> active,
      required final List<Trip> history,
      required final List<Trip> booked}) = _$ErrorImpl;
  const _Error._() : super._();

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get errorMessage;
  List<Trip> get active;
  List<Trip> get history;
  List<Trip> get booked;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
