library vehicle_details;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/cubit/viewed_vehicle_cubit/viewed_vehicle_cubit.dart';
import 'package:emr_005/ecomoto/utils/calculate_price_hour.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/cards/vehicle_location.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:emr_005/ui/components/inputs/star_rating.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/ui/components/widgets/carosel.dart';
import 'package:emr_005/ui/components/widgets/elevated_container.dart';
import 'package:emr_005/ui/components/widgets/video_thumnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/book_now_button.dart';
part 'components/vehicle_description.dart';
part 'components/vehicle_extra_features_view.dart';
part 'components/vehicle_feature_details.dart';
part 'components/vehicle_images.dart';
part 'constants/strings.dart';

class VehicleDetailsView extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailsView({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    context.read<ViewedVehicleCubit>().addViewedVehicle(vehicle.id);

    return Scaffold(
        appBar: AppViewBar.small(
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  VehicleImagesViewer(
                    vehicle: vehicle,
                  ),
                  const SizedBox(height: AppSizes.size10),
                  VehicleDetails(vehicle: vehicle).withHorViewPadding,
                  const SizedBox(height: AppSizes.size10),
                  VehicleExtraFeatures(
                    features: vehicle.extraFeatures,
                  ).withHorViewPadding,
                  const SizedBox(height: AppSizes.size24),
                  const VehicleDescription().withHorViewPadding
                ],
              ),
            )),
            BookVehicleButton(vehicle: vehicle)
          ],
        ));
  }
}
