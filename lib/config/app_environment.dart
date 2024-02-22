/*
  Configuration based on different environments
  like development, production, staging, etc.
  For example, different API base URLs for different environments.
 */
import 'dart:developer';

import 'package:aiprise_flutter_sdk/aiprise_flutter_sdk.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  AppEnvironment._();

  static late bool isWalletConnectModal;

  static bool get isDevelopment => environmentConfig == Environment.development;

  static late Environment? environmentConfig;

  static init(Environment arg, {bool useWalletConnectModal = true}) async {
    await dotenv.load(fileName: ".env");
    environmentConfig = arg;
    isWalletConnectModal = useWalletConnectModal;
    log("Initialized", name: "Environment Config");
  }

  static Environment get environment {
    if (environmentConfig == null) {
      throw Exception('Environment has not been initialized. Call init first.');
    } else {
      return environmentConfig!;
    }
  }

  static bool get useWalletConnectModal {
    return isWalletConnectModal;
  }

  static String get baseUrl {
    return dotenv.env["${environment.value}_BASE_URL"]!;
  }

  static String get walletConnectID {
    return dotenv.env["${environment.value}_WALLET_CONNECT_ID"]!;
  }

  static String get transakKey {
    return dotenv.env["${environment.value}_TRANSAK_KEY"]!;
  }

  static String get pinataToken {
    try {
      return dotenv.env["${environment.value}_PINATA_TOKEN"]!;
    } catch (e) {
      print(e);
      return 'Test';
    }
  }

  static String get marketValueKey {
    return dotenv.env["${environment.value}_MARKET_VALUE_KEY"]!;
  }

  static String get googleMapsApiKey {
    return dotenv.env['GOOGLE_API_KEY']!;
  }

  static String get rpcURL {
    return "https://polygon-mumbai.g.alchemy.com/v2/rU-nyBnC6PbfXZOYWceIoD3m3m4c9vI-";
  }

  static String get smartCarClientId {
    return dotenv.env["${environment.value}_SMART_CAR_KEY"]!;
  }

  static ({AiPriseEnvironment mode, String templateID, String apiKey})
      get aiPrice {
    final aiPriseKey = dotenv.env["${environment.value}_AI_PRISE_KEY"]!;
    final templateKey = dotenv.env['AI_PRISE_TEMPLATE_KEY']!;
    if (environment == Environment.production) {
      return (
        mode: AiPriseEnvironment.production,
        templateID: templateKey,
        apiKey: aiPriseKey
      );
    }
    return (
      mode: AiPriseEnvironment.sandbox,
      templateID: templateKey,
      apiKey: aiPriseKey
    );
  }
}
