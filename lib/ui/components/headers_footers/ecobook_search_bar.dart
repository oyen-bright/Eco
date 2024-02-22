import 'dart:ui';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';


class EcobookSearchBar extends StatelessWidget {
  final void Function()? onTap;
  final String hint;
  final double? elevation;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;

  const EcobookSearchBar({
    super.key,
    this.onTap,
    required this.hint,
    this.elevation,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal, vertical: 5),
          child: Material(
            color: AppColors.searchBarColor,
            elevation: elevation ?? 0,
            borderRadius:
            BorderRadius.circular(AppConstants.borderRadius),
            child: TextField(
              focusNode: focusNode,
              textCapitalization: textCapitalization,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  prefixIcon: const Icon(Icons.search)),
            ),
          )
        ),
      ),
    );
  }
}
