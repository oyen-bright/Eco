// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_manager_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheManagerModelAdapter extends TypeAdapter<CacheManagerModel> {
  @override
  final int typeId = 2;

  @override
  CacheManagerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheManagerModel()
      ..locationCache = (fields[0] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map?)?.cast<dynamic, dynamic>()))
      ..locationDirectionCache = (fields[1] as Map?)?.map(
          (dynamic k, dynamic v) =>
              MapEntry(k as String, (v as Map?)?.cast<dynamic, dynamic>()));
  }

  @override
  void write(BinaryWriter writer, CacheManagerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.locationCache)
      ..writeByte(1)
      ..write(obj.locationDirectionCache);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheManagerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
