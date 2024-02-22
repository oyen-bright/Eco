/*
  Configuration related to app's local database,
  like database name, version, tables, etc.
 */

import 'dart:convert';
import 'dart:developer';

import 'package:emr_005/utils/enums.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'local_storage_model.dart';
import 'secure_storage_keys.dart';

class LocalStorage {
  LocalStorage._();

  static late final FlutterSecureStorage _secureStorage;

  static Future<void> init() async {
    try {
      _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ));
      Hive.registerAdapter(LocalStorageModelAdapter());
      await Hive.openBox<LocalStorageModel>(LocalStorageModel.boxName);

      //TODO is this redundant ??
      deleteSmartCarAccessToken();
      deleteAccessToken();

      log("Initialized", name: "Local Storage");
    } catch (e) {
      log(e.toString(), name: "Local Storage");
    }
  }

  static LocalStorageModel get _localStorageData {
    final box = Hive.box<LocalStorageModel>(LocalStorageModel.boxName);
    try {
      return box.get(0, defaultValue: LocalStorageModel()) ??
          LocalStorageModel();
    } catch (e) {
      return LocalStorageModel();
    }
  }

  static Future<void> _save(LocalStorageModel localStorage) async {
    final box = Hive.box<LocalStorageModel>(LocalStorageModel.boxName);
    try {
      await box.putAt(0, localStorage);
    } catch (e) {
      box.put(0, localStorage);
    }
  }

  static Future<void> saveAccessToken(String token) async {
    final data = LocalStorage._localStorageData;
    data.accessToken = token;
    await LocalStorage._save(data);
  }

  static Future<void> saveSmartCarAccessToken(String token) async {
    final data = LocalStorage._localStorageData;
    data.smartCarAccessToken = token;
    await LocalStorage._save(data);
  }

  static Future<void> deleteSmartCarAccessToken() async {
    final data = LocalStorage._localStorageData;
    data.smartCarAccessToken = null;
    await LocalStorage._save(data);
  }

  static Future<void> deleteAccessToken() async {
    final data = LocalStorage._localStorageData;
    data.accessToken = null;
    await LocalStorage._save(data);
  }

  static Future<void> onRecentlyViewedVehicle(String? vehicleId,
      [StorageAction action = StorageAction.add]) async {
    switch (action) {
      case StorageAction.add:
        if (vehicleId == null) {
          return;
        }
        _localStorageData.recentlyViewedVehicles?.remove(vehicleId);
        _localStorageData.recentlyViewedVehicles?.insert(0, vehicleId);
        if (_localStorageData.recentlyViewedVehicles != null &&
            _localStorageData.recentlyViewedVehicles!.length > 10) {
          _localStorageData.recentlyViewedVehicles!.removeLast();
        }
        break;
      case StorageAction.remove:
        _localStorageData.recentlyViewedVehicles?.remove(vehicleId);
        break;
      case StorageAction.clear:
        _localStorageData.recentlyViewedVehicles?.clear();
        break;
    }

    await _save(_localStorageData);
  }

  static List<String> get recentlyViewedVehicles {
    return _localStorageData.recentlyViewedVehicles ?? [];
  }

  static Future<void> saveGeneratedWallet(
      {required String mnemonic,
      required String privateKey,
      required String publicKey}) async {
    await _secureStorage.write(
        key: SecureStorageKeys.generatedWallet,
        value: jsonEncode({
          "mnemonic": mnemonic,
          "privateKey": privateKey,
          'publicKey': publicKey
        }));
  }

  static String? get accessToken {
    return _localStorageData.accessToken;
  }

  static String? get smartCarAccessToken {
    return _localStorageData.smartCarAccessToken;
  }

  static Future<void> saveUserId(String id) async {
    final data = LocalStorage._localStorageData;
    data.userId = id;
    await LocalStorage._save(data);
  }

  static String? get userId {
    return _localStorageData.userId;
  }

  static Future<({String mnemonic, String privateKey, String publicKey})?>
      get generatedWallet async {
    final walletInformation =
        await _secureStorage.read(key: SecureStorageKeys.generatedWallet);
    if (walletInformation != null) {
      final walletInfoMap =
          Map<String, String>.from(jsonDecode(walletInformation));

      return (
        mnemonic: walletInfoMap["mnemonic"]!,
        privateKey: walletInfoMap["privateKey"]!,
        publicKey: walletInfoMap['publicKey']!
      );
    }
    return null;
  }
}
