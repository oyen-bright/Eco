// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStorageModelAdapter extends TypeAdapter<LocalStorageModel> {
  @override
  final int typeId = 1;

  @override
  LocalStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStorageModel()
      ..accessToken = fields[0] as String?
      ..userId = fields[1] as String?
      ..recentlyViewedVehicles = (fields[2] as List?)?.cast<String>()
      ..smartCarAccessToken = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, LocalStorageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.recentlyViewedVehicles)
      ..writeByte(3)
      ..write(obj.smartCarAccessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
