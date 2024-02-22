library locate_vehicle;

import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/dialogs/error_dialog.dart';
import 'package:emr_005/ui/components/overlays/loading_overlay.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/open_setting_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part './constants/strings.dart';
part 'components/distance_container.dart';
part 'components/locate_bottom_sheet.dart';
part 'components/locate_vehicle_map.dart';
part 'components/proximity_dialog.dart';
part 'components/unlock_vehicle_otp.dart';
part 'components/vehicle_located_bottom_sheet.dart';

class LocateVehicleView extends StatelessWidget {
  final Vehicle vehicle;
  final String rentalID;
  const LocateVehicleView(
      {super.key, required this.vehicle, required this.rentalID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LocateVehicleMap(
      vehicle: vehicle,
      rentalID: rentalID,
    ));
  }
}
