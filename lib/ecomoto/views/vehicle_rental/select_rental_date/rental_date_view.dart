library rental_date;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/components/rental_price.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/dialogs/date_picker_dialog.dart';
import 'package:emr_005/ui/components/display/dashed_lines.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../themes/app_colors.dart';

part 'components/confirm_bottom_sheet.dart';
part 'components/rental_date_form.dart';
part 'components/rental_price.dart';
part 'components/supported_tokens.dart';
part 'constants/strings.dart';

class RentalDateView extends StatefulWidget {
  final Vehicle vehicle;
  const RentalDateView({super.key, required this.vehicle});

  @override
  State<RentalDateView> createState() => _RentalDateViewState();
}

class _RentalDateViewState extends State<RentalDateView> {
  @override
  Widget build(BuildContext context) {
    VehicleRentalModel rentalData =
        VehicleRentalModel(pricePerDay: widget.vehicle.pricePerHour.toDouble());
    rentalData
      ..web3VehicleId = widget.vehicle.web3Data?["vehicleId"]
      ..vehicleId = widget.vehicle.id
      ..lessorID = widget.vehicle.lessorID;

    final GlobalKey<RentalDatePickerState> rentalDatePickerKey = GlobalKey();

    return Scaffold(
        appBar: AppViewBar.small(
          title: Strings.appBarTitle,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: AppSizes.size20,
                    ),
                    RentalDatePicker(
                      vehicle: widget.vehicle,
                      key: rentalDatePickerKey,
                      rentalData: rentalData,
                    ),
                    const SizedBox(
                      height: AppSizes.size40,
                    ),
                    // const RentalSupportedToken().withHorViewPadding,
                    const SizedBox(
                      height: AppSizes.size40,
                    ),
                  ],
                ),
              ),
            ),
            TotalRentalPrice(
              vehicle: widget.vehicle,
              rentalData: rentalData,
              validate: () =>
                  rentalDatePickerKey.currentState?.validate() ?? false,
            ),
          ],
        ));
  }
}
