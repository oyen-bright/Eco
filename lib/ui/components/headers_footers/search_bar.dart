import 'dart:ui';

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContainerSearchBar extends StatelessWidget {
  final void Function()? onTap;
  final String hint;
  final double? elevation;
  const ContainerSearchBar(
      {super.key, this.onTap, required this.hint, this.elevation});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.searchBarColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: Material(
            color: AppColors.searchBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: elevation ?? 0,
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  IconButton(onPressed: onTap, icon: const Icon(Icons.search)),
                  Text(hint)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextSearchBar extends StatelessWidget {
  final void Function()? onTap;
  final String hint;
  final double? elevation;
  final bool hasFilter;
  final int? filterCount;
  final TextInputType? keyboardType;
  final bool showBackButton;
  final void Function()? onFilterPressed;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;

  const TextSearchBar({
    super.key,
    this.onTap,
    required this.hint,
    this.elevation,
    this.focusNode,
    this.filterCount,
    this.showBackButton = false,
    this.hasFilter = true,
    this.onFilterPressed,
    this.controller,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
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
          child: Row(
            children: [
              if (showBackButton) ...{
                Material(
                    color: Colors.transparent,
                    elevation: elevation ?? 0,
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundColor: AppColors.searchBarColor,
                      child: IconButton(
                          visualDensity: VisualDensity.compact,
                          style: IconButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => context.pop()),
                    )),
                const SizedBox(
                  width: 4,
                ),
              },
              Expanded(
                child: Material(
                  color: AppColors.searchBarColor,
                  elevation: elevation ?? 0,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                  child: TextField(
                    keyboardType: keyboardType,
                    onTap: onTap,
                    focusNode: focusNode,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: textCapitalization,
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        prefixIcon: const Icon(Icons.search)),
                  ),
                ),
              ),
              if (hasFilter) ...{
                const SizedBox(
                  width: 4,
                ),
                Material(
                    color: Colors.transparent,
                    elevation: elevation ?? 0,
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundColor: AppColors.searchBarColor,
                      child: Badge(
                        isLabelVisible: filterCount != null,
                        label: Text(
                          filterCount.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        child: IconButton(
                            visualDensity: VisualDensity.compact,
                            style: IconButton.styleFrom(
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            icon: Icon(Icons.filter_list_outlined,
                                color: context.colorScheme.onBackground),
                            onPressed: onFilterPressed),
                      ),
                    ))
              }
            ],
          ),
        ),
      ),
    );
  }
}
