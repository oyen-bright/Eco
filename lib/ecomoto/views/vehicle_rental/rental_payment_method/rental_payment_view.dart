library rental_payment;

import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/rental_price.dart';

part 'components/total_price_view.dart';
part 'constants/strings.dart';

class RentalPaymentView extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;

  const RentalPaymentView({
    Key? key,
    required this.vehicle,
    required this.rentalData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppViewBar.small(
          title: Strings.appBarTitle,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // const RentalSupportedToken().withHorViewPadding,
            const Spacer(),

            // const SizedBox(
            //   height: AppSizes.size20,

            // ),
            // const RentalDepositTextBar(),
            // Expanded(
            //     child: RentalTokenSelect(
            //   vehicle: vehicle,
            // )),
            TotalRentalPricePayment(vehicle: vehicle, rentalData: rentalData),
          ],
        ));
  }
}
