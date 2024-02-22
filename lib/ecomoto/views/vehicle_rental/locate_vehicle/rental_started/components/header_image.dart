import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.startTripIcon,
        scale: 2,
      ),
    );
  }
}
