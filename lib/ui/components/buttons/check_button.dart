import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

class AppCheckButton extends StatelessWidget {
  final bool isChecked;
  final Function(bool)? onChanged;

  const AppCheckButton(
      {Key? key, required this.isChecked, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!isChecked);
      },
      child: Container(
        width: AppSizes.size18,
        height: AppSizes.size18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isChecked ? context.colorScheme.primary : Colors.transparent,
          border: isChecked
              ? Border.all(width: .50, color: Colors.transparent)
              : Border.all(width: .50, color: Colors.black),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: AppSizes.size16,
                color: context.colorScheme.background,
              )
            : null,
      ),
    );
  }
}
