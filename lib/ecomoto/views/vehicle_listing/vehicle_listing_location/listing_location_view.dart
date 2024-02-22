library listing_location;

import 'dart:async';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/buttons/toggle_button.dart';
import 'package:emr_005/ui/components/overlays/loading_overlay.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../themes/app_colors.dart';

part 'components/choose_location_string.dart';
part 'components/form_header_text.dart';
part 'components/listing_location_form.dart';
part 'components/location_picker.dart';
part 'components/vehicle_location_space_toggle.dart';
part 'constants/strings.dart';

class ListingLocationView extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const ListingLocationView({super.key, required this.vehicleInputData});

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
            const SizedBox(height: AppSizes.size20),
            Expanded(
                child: ListingLocationForm(
              vehicleInputData: vehicleInputData,
            )),
            const SizedBox(height: AppSizes.size10),
          ],
        ),
      ),
    );
  }
}
