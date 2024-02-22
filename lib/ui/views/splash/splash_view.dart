library splash;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'components/bottom_image.dart';
part 'components/center_content.dart';
part 'components/top_image.dart';
part 'constants/constants.dart';
part 'constants/strings.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Constants.animationDuration,
        () => AppRouter.router.pushReplacement(AppRoutes.onBoarding));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.background,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 0, left: 0, child: TopImage()),
          Positioned(bottom: 0, right: 0, child: BottomImage()),
          Center(
            child: CenterContent(),
          ),
        ],
      ),
    );
  }
}
