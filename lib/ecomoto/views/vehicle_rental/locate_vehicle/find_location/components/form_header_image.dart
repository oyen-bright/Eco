import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

class FormHeaderImage extends StatelessWidget {
  const FormHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.locateVehicleImage,
      ),
    );
  }
}
