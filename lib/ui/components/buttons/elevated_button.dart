import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? titleColor;
  final String title;
  final bool showIcon;
  final bool isIconReversed;
  final Object? icon;
  final Color? disabledBackgroundColor;
  final Widget? child;
  final TextStyle? textStyle;
  final VisualDensity? visualDensity;
  final double? elevation;

  const AppElevatedButton(
      {super.key,
      this.textStyle,
      this.isLoading = false,
      this.onPressed,
      this.elevation,
      this.borderRadius,
      this.disabledBackgroundColor,
      this.showIcon = false,
      this.icon,
      required this.title,
      this.padding,
      this.backgroundColor,
      this.borderColor,
      this.titleColor,
      this.visualDensity,
      this.child,
      this.isIconReversed = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        disabledBackgroundColor: disabledBackgroundColor,
        visualDensity: visualDensity,
        padding: padding ?? AppConstants.contentPadding,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 1)
              : BorderSide.none,
          borderRadius: borderRadius == null
              ? BorderRadius.circular(AppConstants.borderRadius)
              : borderRadius!,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: showIcon
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!isIconReversed)
                  Text(
                    title,
                    style: AppTextStyles.buttonTextStyle.copyWith(
                        fontSize: textStyle?.fontSize,
                        fontWeight: textStyle?.fontWeight,
                        color: titleColor ?? context.colorScheme.onPrimary),
                  ),
                if (icon is IconData)
                  Icon(icon as IconData,
                      color: titleColor ?? context.colorScheme.onPrimary)
                else
                  icon as Widget,
                if (isIconReversed)
                  Text(
                    title,
                    style: AppTextStyles.buttonTextStyle.copyWith(
                        fontSize: textStyle?.fontSize,
                        fontWeight: textStyle?.fontWeight,
                        color: titleColor ?? context.colorScheme.onPrimary),
                  ),
              ],
            )
          : isLoading
              ? const SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(

                      // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                )
              : child ??
                  Text(
                    title,
                    style: AppTextStyles.buttonTextStyle.copyWith(
                        fontSize: textStyle?.fontSize,
                        fontWeight: textStyle?.fontWeight,
                        color: titleColor ?? context.colorScheme.onPrimary),
                  ),
    );
  }

  factory AppElevatedButton.outlined({
    required String title,
    void Function()? onPressed,
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    Color? titleColor,
    double? elevation,
    double? fontSize,
    EdgeInsets? padding,
  }) {
    return AppElevatedButton(
      title: title,
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      borderColor: borderColor ?? AppColors.primaryColor,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppConstants.borderRadius),
      elevation: elevation,
      visualDensity: VisualDensity.compact,
      textStyle:
          TextStyle(fontSize: fontSize ?? 12, fontWeight: FontWeight.bold),
      padding: padding ?? EdgeInsets.zero,
    );
  }
  factory AppElevatedButton.withIcon({
    required String title,
    void Function()? onPressed,
    Color? backgroundColor,
    Color? borderColor,
    required Object icon,
    final Color? disabledBackgroundColor,
    BorderRadius? borderRadius,
    Color? foregroundColor,
    double? elevation,
    double? fontSize,
    VisualDensity? visualDensity = VisualDensity.compact,
    bool isIconReversed = false,
    EdgeInsets? padding,
  }) {
    return AppElevatedButton(
      title: title,
      isIconReversed: isIconReversed,
      icon: icon,
      titleColor: foregroundColor,
      backgroundColor: backgroundColor,
      showIcon: true,
      disabledBackgroundColor: disabledBackgroundColor,
      onPressed: onPressed,
      borderColor: borderColor ?? AppColors.primaryColor,
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppConstants.borderRadius),
      elevation: elevation,
      visualDensity: visualDensity,
      padding: padding ?? EdgeInsets.zero,
    );
  }

  factory AppElevatedButton.small(
      {required String title,
      void Function()? onPressed,
      Color? backgroundColor,
      Color? borderColor,
      BorderRadius? borderRadius,
      Color? titleColor,
      double? elevation,
      double? fontSize,
      Widget? child,
      EdgeInsets? padding}) {
    return AppElevatedButton(
      title: title,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius ?? BorderRadius.zero,
      elevation: elevation,
      visualDensity: VisualDensity.compact,
      textStyle:
          TextStyle(fontSize: fontSize ?? 12, fontWeight: FontWeight.bold),
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}
