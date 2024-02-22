import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../themes/app_text_styles.dart';

class AppElevatedButtonWithIcon extends StatelessWidget {
  final Color? backgroundColor;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final double? elevation;
  final bool navigateForward;
  final bool navigateBackward;

  const AppElevatedButtonWithIcon({
    Key? key,
    this.onPressed,
    this.title,
    this.elevation,
    this.padding,
    this.backgroundColor,
    this.navigateForward = false,
    this.navigateBackward = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isForward = navigateForward && !navigateBackward;
    final isBackward = !navigateForward && navigateBackward;

    final backgroundColor = isForward
        ? context.colorScheme.primary
        : isBackward
            ? context.theme.scaffoldBackgroundColor
            : this.backgroundColor;

    final textColor = isForward
        ? Colors.white
        : isBackward
            ? context.colorScheme.primary
            : context.colorScheme.onPrimary;

    final iconColor = isForward
        ? context.colorScheme.onPrimary
        : isBackward
            ? context.colorScheme.primary
            : context.colorScheme.onPrimary;

    final computedTitle = title ??
        (isForward
            ? 'Proceed'
            : isBackward
                ? 'Back'
                : '');

    final computedElevation = elevation ?? (isBackward ? 0 : null);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ?? AppConstants.contentPadding,
        backgroundColor: backgroundColor,
        elevation: computedElevation,
        shape: RoundedRectangleBorder(
          side: isBackward
              ? BorderSide(width: 2, color: context.colorScheme.primary)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isBackward) Icon(Icons.arrow_back, color: iconColor),
          Text(
            computedTitle,
            style: AppTextStyles.buttonTextStyle.copyWith(
              color: textColor,
            ),
          ),
          if (isForward) Icon(Icons.arrow_forward, color: iconColor),
        ],
      ),
    );
  }
}
