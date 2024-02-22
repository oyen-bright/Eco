library rental_payment_successful;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../../router/app_router.dart';
import '../models/rental_input_data.dart';

part 'components/form_center_text.dart';
part 'components/form_header_image.dart';
part 'constants/strings.dart';

class RentalPaymentSuccessful extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalModel;
  const RentalPaymentSuccessful(
      {super.key, required this.vehicle, required this.rentalModel});

  @override
  Widget build(BuildContext context) {
    const isRentalDate = true;
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
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FormHeaderImage(),
                FormCenterText(
                  amountPaid: rentalModel.amountToPay.toString(),
                ),
              ],
            )),

            //Todo: is RentalDate
            AppElevatedButton(
              title: isRentalDate
                  ? Strings.locateVehicleButtonText
                  : Strings.homePageButtonText,
              onPressed: () {
                isRentalDate
                    ? AppRouter.router
                        .push(EcomotoRoutes.vehicleRentalLocateView, extra: {
                        'vehicle': vehicle,
                        'rentalID': rentalModel.rentalId
                      })
                    : AppRouter.router.go(EcomotoRoutes.home, extra: vehicle);
              },
            )
          ],
        ),
      ),
    ));
  }
}
