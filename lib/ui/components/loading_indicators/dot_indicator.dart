import 'dart:async';

import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DotLoadingIndicator extends StatefulWidget {
  const DotLoadingIndicator({super.key});

  @override
  DotLoadingIndicatorState createState() => DotLoadingIndicatorState();
}

class DotLoadingIndicatorState extends State<DotLoadingIndicator> {
  int dotIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        dotIndex = (dotIndex + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            if (i == dotIndex)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
                height: AppSizes.size10,
                width: AppSizes.size10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.onBackground),
              )
            else
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSizes.size2),
                height: AppSizes.size10,
                width: AppSizes.size10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.lightGreyColor),
              )
        ],
      ).animate().slideY(),
    );
  }
}
