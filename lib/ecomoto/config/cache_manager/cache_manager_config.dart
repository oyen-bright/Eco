import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import 'cache_manager_model.dart';

class CacheManager {
  CacheManager._();
  static Future<void> init() async {
    try {
      Hive.registerAdapter(CacheManagerModelAdapter());
      await Hive.openBox<CacheManagerModel>(CacheManagerModel.boxName);

      log("Initialized", name: "Cache Manager");
    } catch (e) {
      log(e.toString(), name: "Cache Manager ");
    }
  }

  static CacheManagerModel get _cacheData {
    final box = Hive.box<CacheManagerModel>(CacheManagerModel.boxName);
    try {
      return box.get(0, defaultValue: CacheManagerModel()) ??
          CacheManagerModel();
    } catch (e) {
      return CacheManagerModel();
    }
  }

  static Future<void> _save(CacheManagerModel appConfigInfo) async {
    final box = Hive.box<CacheManagerModel>(CacheManagerModel.boxName);
    try {
      await box.putAt(0, appConfigInfo);
    } catch (e) {
      box.put(0, appConfigInfo);
    }
  }

  static Future<void> writeLocationCache(
      String key, ({String distance, String duration})? value,
      {bool isAvailable = true}) async {
    final data = _cacheData;
    data.locationCache ??= {};

    data.locationCache?[key] = {
      "distance": value?.distance,
      "duration": value?.duration,
      "isAvailable": isAvailable
    };
    await _save(data);
  }

  static ({bool isAvailable, ({String distance, String duration}) data})?
      readLocationCache(String key) {
    final data = _cacheData.locationCache?[key];
    if (data == null) {
      return null;
    } else {
      return (
        isAvailable: data['isAvailable'],
        data: (
          distance: data['distance'],
          duration: data['duration'],
        )
      );
    }
  }

  static Future<void> writeDirectionLocationCache(
      String key, ({String distance, String duration, List steps})? value,
      {bool isAvailable = true}) async {
    final data = _cacheData;
    data.locationDirectionCache ??= {};
    data.locationDirectionCache?[key] = {
      "distance": value?.distance,
      "duration": value?.duration,
      "steps": value?.steps,
      "isAvailable": isAvailable
    };
    await _save(data);
  }

  static ({
    bool isAvailable,
    ({String distance, String duration, List steps}) data
  })? readDirectionLocationCache(String key) {
    final data = _cacheData.locationDirectionCache?[key];
    if (data == null) {
      return null;
    } else {
      return (
        isAvailable: data['isAvailable'],
        data: (
          distance: data['distance'],
          duration: data['duration'],
          steps: data['steps']
        )
      );
    }
  }
}
