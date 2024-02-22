import 'dart:async';
import 'dart:developer';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/config/smart_car_config/smart_car_config.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_car_authentication/smart_car_authentication.dart';

mixin SmartCarMixin {
  //TODO Delete this

  testSmartCar(BuildContext context) async {
    final response = await context
        .read<VehicleService>()
        .connectSmartCar(smartCarToken: "74694b22-4c8b-4f14-8fc5-b57742fd9a88");

    response.vehicles?.forEach((element) {
      print(element.toString());
    });
  }

  Future<List<SmartCarVehicle>?> connectSmartCar(BuildContext context) async {
    try {
      //TODO:Note for test only
      // if (LocalStorage.smartCarAccessToken != null) {
      //   final res = await context
      //       .read<VehicleCubit>()
      //       .getSmartCarVehicles(token: "ea746b3c-02d4-40ad-9c2f-ed365257ab5f");

      //   return res.vehicles;
      // }

      Completer<List<SmartCarVehicle>?> completer = Completer();

      SmartCar.authenticate();
      SmartCar.eventListener(
          Smartcar.onSmartcarResponse.listen((response) async {
        if (response.code != null) {
          log(response.code.toString(), name: "Smart car Connect Code");

          final res = await context
              .read<VehicleCubit>()
              .getSmartCarVehicles(token: response.code!);

          if (res.error != null) {
            // ignore: use_build_context_synchronously
            _showError(context, res.error!);
            completer.complete(null);
          } else {
            completer.complete(res.vehicles);
          }
        } else {
          _showError(
              context,
              response.errorDescription ??
                  response.error ??
                  "An Error occurred connecting to SmartCar please try again");

          completer.complete(null);
        }
      }));

      return completer.future;
    } catch (e) {
      log(e.toString(), name: "Smart Car Connect");
      _showError(context, AppConstants.appErrorMessage);

      return null;
    }
  }

  void _showError(BuildContext context, String error) {
    if (context.mounted) {
      context.showSnackBar(error);
    }
  }
}
