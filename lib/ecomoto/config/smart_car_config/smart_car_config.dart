import 'dart:async';
import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:smart_car_authentication/smart_car_authentication.dart';

class SmartCar {
  static final String _smartCarClientId = AppEnvironment.smartCarClientId;
  static Future<void> init() async {
    await Smartcar.setup(
      configuration: SmartcarConfig(
        clientId: _smartCarClientId,
        redirectUri: "sc$_smartCarClientId://${AppConstants.appHostName}",
        scopes: [
          SmartcarPermission.readVin,
          SmartcarPermission.readOdometer,
          SmartcarPermission.controlSecutiry,
          SmartcarPermission.readBattery,
          SmartcarPermission.readCharge,
          SmartcarPermission.readVehicleInfo,
          SmartcarPermission.readExtendedVehicleInfo,
          SmartcarPermission.readLocation,
          SmartcarPermission.readVin,
          SmartcarPermission.readTires,
          SmartcarPermission.readEngineOil,
          SmartcarPermission.readFuel
        ],
        testMode: AppEnvironment.isDevelopment,
      ),
    );
    log("Smartcar Initialized", name: "Smart Car");
    eventListener(Smartcar.onSmartcarResponse.listen((response) {
      log("Smartcar Response: $response", name: "Smart Car");
    }));
  }

  static authenticate() {
    Smartcar.launchAuthFlow();
  }

  static void eventListener(StreamSubscription<SmartcarAuthResponse> listen) {
    Smartcar.onSmartcarResponse.listen;
  }
}
