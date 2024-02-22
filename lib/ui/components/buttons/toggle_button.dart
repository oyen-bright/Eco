import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../themes/sizes.dart';

class AppToggleButton extends StatelessWidget {
  final bool isSelected;
  final void Function(bool) onToggle;
  const AppToggleButton(
      {super.key, required this.isSelected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        width: AppSizes.size70,
        height: AppSizes.size30,
        activeColor: context.colorScheme.primary,
        inactiveColor: AppColors.inactiveToggleButtonColor,
        activeTextColor: context.colorScheme.onPrimary,
        inactiveTextColor: context.colorScheme.onSecondary,
        activeTextFontWeight: FontWeight.w400,
        inactiveTextFontWeight: FontWeight.w400,
        activeText: "YES",
        inactiveText: "NO",
        value: isSelected,
        borderRadius: 25.0,
        padding: 3.0,
        showOnOff: true,
        onToggle: onToggle);
  }
}
