import 'dart:math';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/bottom_sheets/add_wallet.dart';
import 'package:emr_005/ui/components/bottom_sheets/bottom_sheet.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

extension AddWalletBottomSheet on Widget {
  Future<T?> asAddWalletBottomSheet<T>(BuildContext context,
      {required String title,
      void Function()? onClose,
      bool isDismissible = true}) {
    return addWalletBottomSheet<T>(context,
        child: this,
        title: title,
        isDismissible: isDismissible,
        onClose: onClose);
  }

  Future<T?> asDialog<T>(BuildContext context,
      {String? title, void Function()? onClose, bool isDismissible = true}) {
    return showDialog<T>(
        context: context, builder: (BuildContext context) => this);
  }

  Future<T?> asBottomSheet<T>(BuildContext context,
      {Color? backgroundColor,
      bool? enableDrag,
      bool? isDismissible,
      bool? topSafeArea,
      bool? expand,
      bool invert = false,
      double? elevation,
      HapticFeedbackType? hapticType = HapticFeedbackType.selection,
      bool? bottomSafeArea}) {
    if (hapticType != null) {
      haptic(hapticType);
    }

    return appBottomSheet<T>(
        invert: invert,
        enableDrag: enableDrag,
        expand: expand,
        context: context,
        elevation: elevation,
        topSafeArea: topSafeArea,
        bottomSafeArea: bottomSafeArea ?? true,
        isDismissible: isDismissible,
        backgroundColor: backgroundColor,
        builder: (
          BuildContext context,
        ) =>
            this);
  }

  Widget get withHorViewPadding {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal),
      child: this,
    );
  }

  Widget get withVertViewPadding {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.viewPaddingVertical),
      child: this,
    );
  }

  Widget get withViewPadding {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal,
          vertical: AppConstants.viewPaddingVertical),
      child: this,
    );
  }

  Widget get withContentPadded {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.size10, vertical: AppSizes.size12),
      child: this,
    );
  }

//Fot test purposes only
  Widget get visualize {
    return Container(
      color: Colors
          .primaries[Random().nextInt(Colors.primaries.length)], // Random color
      child: this,
    );
  }
}
