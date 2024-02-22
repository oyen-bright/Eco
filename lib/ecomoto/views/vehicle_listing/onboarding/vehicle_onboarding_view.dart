library vehicle_listing_onboarding;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/mixins/smart_car_mixin.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';

import '../../../../../themes/sizes.dart';

part 'components/gestated_button.dart';
part 'components/onboarding_image_header.dart';
part 'components/onboarding_text.dart';
part 'constants/strings.dart';

class VehicleOnboardingView extends StatelessWidget {
  const VehicleOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const VehicleListingWrapper(
      showAppBar: true,
      automaticallyImplyLeading: true,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnboardingText(),
                      SizedBox(height: AppSizes.size24),
                      OnboardingImageHeader(),
                    ],
                  ),
                ),
              ),
            ),
            GetStartedButton(),
            SizedBox(
              height: AppSizes.size30,
            )
          ],
        ),
      ),
    );
  }
}
