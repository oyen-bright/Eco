import 'package:hive_flutter/hive_flutter.dart';

part 'cache_manager_model.g.dart';

@HiveType(typeId: 2)
class CacheManagerModel {
  static const String boxName = "cache_manager_model";

  @HiveField(0)
  Map<String, Map?>? locationCache = {};

  @HiveField(1)
  Map<String, Map?>? locationDirectionCache = {};
}
