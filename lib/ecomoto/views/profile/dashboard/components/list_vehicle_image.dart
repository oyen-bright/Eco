import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

class ListVehicleImage extends StatelessWidget {
  const ListVehicleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(AppImages.dashboardImage),
    );
  }
}
