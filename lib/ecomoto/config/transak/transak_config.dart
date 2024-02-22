import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:transak/transak.dart';

class TransakPayment {
  TransakPayment._();

  static late final Transak? _transakClient;

  static void init() {
    _transakClient = Transak();
    _transakClient?.config(
        iosModalTitle: "",
        walletRedirection: true,
        environment: TransakEnvironment.test,
        productsAvailed: "BUY",
        themeColor: "215759",
        apiKey: AppEnvironment.transakKey,
        redirectURL: AppConstants.appDomain);
    log("Initialized", name: "Transak");
  }

  static Transak get client {
    if (_transakClient == null) {
      throw Exception(
          'Transak client has not been initialized. Call initialize first.');
    }
    return _transakClient!;
  }

  static dispose() {
    client.dispose();
  }
}
