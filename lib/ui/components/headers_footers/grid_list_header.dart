import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';

class GridListHeader extends StatelessWidget {
  final String textString;
  final void Function()? onPressed;
  const GridListHeader(
      {super.key, required this.textString, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textString, style: context.textTheme.titleMedium!),
          if (onPressed != null)
            TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              onPressed: onPressed,
              child: Text(
                "View All",
                style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600),
              ),
            )
        ],
      ).withHorViewPadding,
    );
  }
}
