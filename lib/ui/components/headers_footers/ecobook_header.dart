import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EcobookHeader extends StatelessWidget {
  const EcobookHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.logo,
          height: AppSizes.size48,
          width: AppSizes.size48,
        ).animate().fadeIn(),
        const SizedBox(width: AppSizes.size1),
        const Flexible(
          child: Text(
            AppConstants.ecobookName,
            style: AppTextStyles.titleTextStyle,
          ),
        ).animate().fadeIn(),
        const Spacer(),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  print('Notification Pressed');
                },
                icon: Image.asset(
                  AppImages.ecobookNotification,
                  height: 20,
                  width: 20,
                )).animate().fadeIn(),
            IconButton(
                onPressed: () {
                  //TODO: messaging route
                  //AppRouter.router.push(AppRoutes.ecoBookMessageChats);
                },
                icon: Image.asset(
                  AppImages.ecobookChat,
                  height: 20,
                  width: 20,
                )).animate().fadeIn(),
          ],
        )
      ],
    );
  }
}
