library vehicle_search_map;

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/headers_footers/search_bar.dart';
import 'package:emr_005/ui/components/inputs/rental_rating.dart';
import 'package:emr_005/ui/components/overlays/loading_overlay.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'components/custom_info_window.dart';
part 'components/google_maps.dart';
part 'constants/strings.dart';

class VehicleSearchMapView extends StatelessWidget {
  const VehicleSearchMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        extendBodyBehindAppBar: true, body: SearchGoogleMapsView());
  }
}
