library select_smart_car;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button_with_icon.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'components/car_details.dart';
part 'components/car_list.dart';
part 'constants/strings.dart';

class SelectSmartCarView extends StatelessWidget {
  final List<SmartCarVehicle> vehicles;
  const SelectSmartCarView({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    SmartCarVehicle? selectedVehicle = vehicles.firstOrNull;

    return VehicleListingWrapper(
      showAppBar: true,
      automaticallyImplyLeading: true,
      title: Strings.viewTitle,
      body: Column(
        children: [
          CarList(
              onSelected: (vehicle) {
                selectedVehicle = vehicle;
              },
              vehicles: vehicles),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            const Spacer(),
            Expanded(
              child: AppElevatedButtonWithIcon(
                onPressed: () {
                  if (selectedVehicle != null) {
                    final data = VehicleModel()
                      ..model = selectedVehicle!.model
                      ..vin = selectedVehicle!.vin
                      ..smartCarVehicle = selectedVehicle!
                      ..mileagePerCharge = selectedVehicle!.battery.range
                      ..brand = selectedVehicle!.make
                      ..modelYear = selectedVehicle!.year;
                    AppRouter.router.push(
                        EcomotoRoutes.vehicleListingGeneralInformation,
                        extra: data);
                  }
                },
                navigateForward: true,
              ),
            ),
          ]),
          const SizedBox(
            height: AppSizes.size10,
          ),
        ],
      ).withHorViewPadding,
    );
  }
}
