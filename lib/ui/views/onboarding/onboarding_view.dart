library on_boarding;

import 'package:emr_005/config/app_config.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/utils/orientation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'components/on_boarding_button.dart';
part 'components/on_boarding_dot_indicator.dart';
part 'components/onboarding_images.dart';
part 'components/onboarding_text.dart';
part 'constants/constants.dart';
part 'constants/strings.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  OnBoardingViewState createState() => OnBoardingViewState();
}

class OnBoardingViewState extends State<OnBoardingView> {
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    setPortraitOrientation();

    super.initState();
  }

  @override
  void dispose() {
    resetPreferredOrientations();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: OnBoardingPageView(controller: _controller),
            ),
            const SizedBox(
              height: AppSizes.size30,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DotIndicator(controller: _controller),
                  Expanded(
                      child: SingleChildScrollView(
                          child: OnBoardingText(controller: _controller))),
                  OnBoardingButton(controller: _controller)
                ],
              ),
            ),
            const SizedBox(
              height: AppSizes.size20,
            ),
          ],
        ),
      ),
    );
  }
}
