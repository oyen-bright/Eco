import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class BackToHomePageButton extends StatelessWidget {
  const BackToHomePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
        onPressed: () {
          AppRouter.router.go(EcomotoRoutes.home);
        },
        backgroundColor: context.colorScheme.onPrimary,
        borderColor: context.colorScheme.primary,
        titleColor: context.colorScheme.primary,
        title: Strings.backToHomeTitle);
  }
}
