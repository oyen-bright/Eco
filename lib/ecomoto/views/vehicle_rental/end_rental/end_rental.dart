library end_rental;

import 'dart:async';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/overlays/loading_overlay.dart';
import 'package:emr_005/ui/components/widgets/app_map.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/open_setting_util.dart';
import 'package:emr_005/utils/parse_distance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'components/distance_container.dart';
part 'components/map.dart';
part 'components/proximity_dialog.dart';
part 'constants/strings.dart';

class EndRentalView extends StatelessWidget {
  final Trip trip;
  const EndRentalView({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LocateVehicleMap(trip: trip));
  }
}
