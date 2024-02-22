import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';

import 'components/form_center_text.dart';
import 'components/form_header_image.dart';
import 'constants/strings.dart';

class FindVehicleLocationView extends StatelessWidget {
  final Vehicle vehicle;
  const FindVehicleLocationView({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical,
            horizontal: AppConstants.viewPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormHeaderImage(),
                FormCenterText(),
              ],
            )),
            AppElevatedButton(
              title: Strings.findLocationButtonText,
              onPressed: () {
                AppRouter.router.push(EcomotoRoutes.vehicleRentalLocateView,
                    extra: vehicle);
              },
            )
          ],
        ),
      ),
    ));
  }
}
