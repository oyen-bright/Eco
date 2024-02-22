import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:siwe_flutter/siwe.dart';

class SIWEthereum {
  static late final SiweFlutter? _siweFlutter;
  static void init() {
    _siweFlutter = SiweFlutter(
        domain: AppConstants.appHostName,
        statement: "Sign in with Ethereum to Ecomoto",
        version: "1",
        uri: AppConstants.appDomain,
        chainId: "80001");
    log("Initialized", name: "SIWE");
  }

  static SiweFlutter get client {
    if (_siweFlutter == null) {
      throw Exception(
          'SiweFlutter client has not been initialized. Call initialize first.');
    }
    return _siweFlutter!;
  }
}
