// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitialImpl _$$InitialImplFromJson(Map<String, dynamic> json) =>
    _$InitialImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InitialImplToJson(_$InitialImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LoadingImpl _$$LoadingImplFromJson(Map<String, dynamic> json) =>
    _$LoadingImpl(
      active: (json['active'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      history: (json['history'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      booked: (json['booked'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadingImplToJson(_$LoadingImpl instance) =>
    <String, dynamic>{
      'active': instance.active,
      'history': instance.history,
      'booked': instance.booked,
      'runtimeType': instance.$type,
    };

_$LoadedImpl _$$LoadedImplFromJson(Map<String, dynamic> json) => _$LoadedImpl(
      active: (json['active'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      history: (json['history'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      booked: (json['booked'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadedImplToJson(_$LoadedImpl instance) =>
    <String, dynamic>{
      'active': instance.active,
      'history': instance.history,
      'booked': instance.booked,
      'runtimeType': instance.$type,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      errorMessage: json['errorMessage'] as String,
      active: (json['active'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      history: (json['history'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      booked: (json['booked'] as List<dynamic>)
          .map((e) => Trip.fromJson(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'active': instance.active,
      'history': instance.history,
      'booked': instance.booked,
      'runtimeType': instance.$type,
    };
