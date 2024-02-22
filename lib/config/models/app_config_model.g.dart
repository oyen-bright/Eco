// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppConfigModelAdapter extends TypeAdapter<AppConfigModel> {
  @override
  final int typeId = 0;

  @override
  AppConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfigModel()
      ..finishedOnboarding = fields[0] as bool?
      ..finishedHomeOnboarding = fields[1] as bool?
      ..userLocation = (fields[3] as Map?)?.cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, AppConfigModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.finishedOnboarding)
      ..writeByte(1)
      ..write(obj.finishedHomeOnboarding)
      ..writeByte(3)
      ..write(obj.userLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
