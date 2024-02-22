library select_images_videos;

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/bottom_sheets/image_picker.dart';
import 'package:emr_005/ui/components/widgets/video_player.dart';
import 'package:emr_005/ui/components/wrappers/vehicle_listing_view_wrapper.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/video_compressor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../themes/app_images.dart';
import '../../../../../ui/components/buttons/elevated_button_with_icon.dart';

part 'components/form_header_text.dart';
part 'components/select_images_videos.dart';
part 'components/show_guidelines_view.dart';
part 'constants/strings.dart';

class ShowCaseVehicleView extends StatelessWidget {
  final VehicleModel vehicleInputData;
  const ShowCaseVehicleView({super.key, required this.vehicleInputData});

  @override
  Widget build(BuildContext context) {
    return VehicleListingWrapper(
      showAppBar: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 25,
            ),
            const FormHeaderText(),
            Expanded(
              child: SelectImagesVideos(vehicleInputData: vehicleInputData),
            ),
            const SizedBox(height: AppSizes.size10),
          ],
        ),
      ),
    );
  }
}
