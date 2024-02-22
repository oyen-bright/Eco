import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget child;
  const ElevatedContainer({super.key, this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ??
            const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingHorizontal,
                vertical: AppConstants.viewPaddingVertical),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: child);
  }
}
