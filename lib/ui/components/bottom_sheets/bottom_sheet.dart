import 'dart:io';

import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> appBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool? expand,
  AnimationController? secondAnimation,
  bool? useRootNavigator,
  bool? bounce,
  bool? isDismissible,
  bool? enableDrag,
  bool bottomSafeArea = true,
  bool invert = false,
  bool? topSafeArea,
  Duration? duration,
}) {
  backgroundColor ??= context.theme.scaffoldBackgroundColor;
  barrierColor ??= Colors.black54;
  expand ??= false;
  useRootNavigator ??= true;
  bounce ??= true;
  topSafeArea ??= false;
  isDismissible ??= true;
  enableDrag ??= true;

  Widget safeAreaWidget(BuildContext context) => SafeArea(
        top: false,
        bottom: bottomSafeArea,
        child: builder(context),
      );

  if (Platform.isIOS && !invert) {
    return showCupertinoModalBottomSheet<T>(
      context: context,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      expand: expand,
      builder: (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: safeAreaWidget(context),
        ),
      ),
      useRootNavigator: useRootNavigator,
      bounce: bounce,
      elevation: elevation,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
    );
  } else {
    return showMaterialModalBottomSheet<T>(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Material(color: backgroundColor, child: safeAreaWidget(context)),
      ),
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      expand: expand,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
    );
  }
}
