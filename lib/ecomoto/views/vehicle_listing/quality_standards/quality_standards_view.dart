library quality_standards_view;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/ui/components/buttons/toggle_button.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../ui/components/buttons/elevated_button_with_icon.dart';

part 'components/form_header_text.dart';
part 'components/quality_forms_widget.dart';
part 'components/quality_standards_form.dart';
part 'constants/strings.dart';

class QualityStandardsView extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const QualityStandardsView({super.key, required this.vehicleInputData});

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
              child: QualityStandardsForm(
                vehicleInputData: vehicleInputData,
              ),
            ),
            const SizedBox(
              height: AppSizes.size10,
            )
          ],
        ),
      ),
    );
  }
}
