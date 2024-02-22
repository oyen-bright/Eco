import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class NameAvatar extends StatelessWidget {
  final String data;
  final Color? backgroundColor;
  final double? customRadius;
  final double? fontSize;
  const NameAvatar({
    Key? key,
    required this.data,
    this.backgroundColor, this.customRadius, this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: customRadius ?? Constants.nameAvatarRadius + 1,
      backgroundColor: Constants.nameAvatarOuterBackgroundColor,
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? context.colorScheme.onBackground,
        foregroundColor: Constants.nameAvatarForegroundColor,
        radius: customRadius ?? Constants.nameAvatarRadius,
        child: Text(
          data.toUpperCase(),
          style: AppTextStyles.nameAvatarTextStyle.copyWith(
            fontSize: fontSize
          ),
        ),
      ),
    );
  }
}
