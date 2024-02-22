import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';

part 'components/back_to_homepage_button.dart';
part 'components/form_center_text.dart';
part 'components/form_header_image.dart';
part 'constants/strings.dart';

class ListingSuccessfulView extends StatelessWidget {
  const ListingSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return const VehicleListingWrapper(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            FormHeaderImage(),
            SizedBox(
              height: AppSizes.size30,
            ),
            FormCenterText(),
            Spacer(
              flex: 2,
            ),
            BackToHomePage(),
            SizedBox(height: AppSizes.size10),
          ],
        ),
      ),
    ));
  }
}
