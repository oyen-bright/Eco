library insurance_information;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/bottom_sheets/image_picker.dart';
import 'package:emr_005/ui/components/dialogs/date_picker_dialog.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../ui/components/buttons/elevated_button_with_icon.dart';

part 'components/form_header_text.dart';
part 'components/insurance_information_form.dart';
part 'constants/strings.dart';

class InsuranceInformationView extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const InsuranceInformationView({super.key, required this.vehicleInputData});

  @override
  Widget build(BuildContext context) {
    return VehicleListingWrapper(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const FormHeaderText(),
          const SizedBox(
            height: AppSizes.size20,
          ),
          Expanded(
              child:
                  InsuranceInformationForm(vehicleInputData: vehicleInputData)),
          const SizedBox(
            height: AppSizes.size10,
          ),
        ],
      ),
    ));
  }
}
