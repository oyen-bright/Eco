library rental_agreement;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:emr_005/ui/components/widgets/elevated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'components/agree_button.dart';
part 'components/agreement_text.dart';
part 'constants/strings.dart';

class RentalAgreementView extends StatelessWidget {
  final Vehicle vehicle;
  final VehicleRentalModel rentalData;

  const RentalAgreementView(
      {super.key, required this.vehicle, required this.rentalData});

  @override
  Widget build(BuildContext context) {
    // Create the ScrollController
    final ScrollController scrollController = ScrollController();

    return Scaffold(
        appBar: AppViewBar.small(
          title: Strings.appBarTitle,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RentalAgreementDescription(
                vehicle: vehicle,
                scrollController: scrollController,
              ).withHorViewPadding,
            ),
            RentalAgreeButton(
              vehicle: vehicle,
              rentalData: rentalData,
              scrollController: scrollController,
            ),
          ],
        ));
  }
}
