import 'package:hive_flutter/hive_flutter.dart';

part 'app_config_model.g.dart';

@HiveType(typeId: 0)
class AppConfigModel {
  static const String boxName = "app_config_model";

  @HiveField(0)
  bool? finishedOnboarding = false;

  @HiveField(1)
  bool? finishedHomeOnboarding = false;

  @HiveField(3)
  Map<String, String>? userLocation;
}
