library select_vehicle_plan;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'components/available_plans.dart';
part 'components/header_text.dart';
part 'components/plan_card.dart';
part 'constants/strings.dart';

class SelectVehiclePlanView extends StatelessWidget {
  final VehicleModel vehicleInputData;

  const SelectVehiclePlanView({super.key, required this.vehicleInputData});

  @override
  Widget build(BuildContext context) {
    return VehicleListingWrapper(
        showAppBar: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: AppSizes.size20,
              ),
              const HeaderText(),
              const SizedBox(
                height: AppSizes.size20,
              ),
              Expanded(
                  child: AvailablePlans(
                vehicleInputData: vehicleInputData,
              )),
              const SizedBox(
                height: AppSizes.size10,
              ),
            ],
          ),
        ));
  }
}
