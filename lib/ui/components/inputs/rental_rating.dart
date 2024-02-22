import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

class RentalRating extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final Color iconColor;
  final Color textColor;
  final double rating;
  final int ratingCount;
  final int totalRating;

  const RentalRating({
    Key? key,
    this.iconSize = AppSizes.size12,
    this.fontSize = AppSizes.size10,
    this.iconColor = AppColors.ratingColor,
    this.textColor = AppColors.primaryLight,
    this.rating = 5.0,
    this.ratingCount = 12,
    this.totalRating = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          size: iconSize,
          color: iconColor,
        ),
        Text(
          '$rating ($ratingCount)',
          maxLines: 1,
          style: context.textTheme.labelSmall!.copyWith(
            fontSize: fontSize,
            letterSpacing: -0.3,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
