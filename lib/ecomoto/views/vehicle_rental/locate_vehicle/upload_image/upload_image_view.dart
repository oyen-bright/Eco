library rental_images;

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/bottom_sheets/image_picker.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'components/form_header_text.dart';
part 'components/upload_image.dart';
part 'constants/strings.dart';

class UploadRentalImage extends StatelessWidget {
  final String rentalID;
  const UploadRentalImage({super.key, required this.rentalID});

  @override
  Widget build(BuildContext context) {
    List<XFile?> images = [null, null, null, null, null, null];

    void onContinue() async {
      if (!images.any((element) => element == null)) {
        const imageTitles = [
          "frontImage",
          "leftImage",
          "backImage",
          "rightImage",
          "insideBack",
          "insideFront"
        ];

        final formattedImages =
            images.mapIndexed((index, e) => (imageTitles[index], e!)).toList();

        final response = await context
            .read<VehicleCubit>()
            .onTripStartTrip(rentalId: rentalID, images: formattedImages);
        if (response.error != null) {
          if (context.mounted) {
            context.showSnackBar(response.error);
          }
        } else {
          AppRouter.router
              .pushReplacement(EcomotoRoutes.vehicleRentalStartedView);
        }
      } else {
        context.showSnackBar(Strings.imageUploadError);
      }
    }

    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingHorizontal),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FormHeaderText(),
                  const SizedBox(
                    height: AppSizes.size10,
                  ),
                  UploadRentalImages(
                    images: images,
                  ),
                  const Spacer(),
                  AppElevatedButton(
                      title: Strings.uploadImageButtonText,
                      onPressed: onContinue),
                  const SizedBox(
                    height: AppSizes.size10,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
