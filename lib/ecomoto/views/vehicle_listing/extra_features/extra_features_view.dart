library extra_feature;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../themes/sizes.dart';

part 'components/dropdown_extra_features.dart';
part 'components/extra_features_form.dart';
part 'components/extra_features_header.dart';
part 'constants/strings.dart';

class ExtraFeaturesView extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const ExtraFeaturesView({super.key, required this.vehicleInputData});

  @override
  Widget build(BuildContext context) {
    return VehicleListingWrapper(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const ExtraFeaturesHeaderText(),
            const SizedBox(
              height: AppSizes.size20,
            ),
            Expanded(
              child: ExtraFeaturesForm(
                vehicleInputData: vehicleInputData,
              ),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
          ],
        ),
      ),
    );
  }
}
