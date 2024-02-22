import 'dart:ui';

import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    Key? key,
    required TabController tabController,
    required List<String> tabNames,
    double? elevation,
    Color? backgroundColor,
  })  : _tabController = tabController,
        _tabNames = tabNames,
        // _backgroundColor = backgroundColor,
        _elevation = elevation,
        super(key: key);

  final TabController _tabController;
  final List<String> _tabNames;
  // final Color? _backgroundColor;
  final double? _elevation;

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  late final List<(String, GlobalKey<State<StatefulWidget>>)> _tabDetails;

  @override
  void initState() {
    super.initState();
    _tabDetails = widget._tabNames.map((e) => (e, GlobalKey())).toList();

    widget._tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (widget._tabController.index != _currentIndex) {
      _currentIndex = widget._tabController.index;
      Scrollable.ensureVisible(_tabDetails[_currentIndex].$2.currentContext!,
              // duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignmentPolicy: _currentIndex == 0
                  ? ScrollPositionAlignmentPolicy.keepVisibleAtStart
                  : ScrollPositionAlignmentPolicy.keepVisibleAtEnd)
          .then((value) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget._tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: widget._elevation ?? 0,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
              ),
              // border:
              //     const Border(bottom: BorderSide(color: Colors.green))),
              // color: context.theme.scaffoldBackgroundColor,
              width: double.infinity,
              height: kToolbarHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: AppSizes.size20),
                  //     child: Row(
                  //       children: _buildTabs(context),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: _scrollController,
                      padding: const EdgeInsets.only(left: AppSizes.size20),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildTabs(context, _tabDetails),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  )
                ],
              )),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context,
      List<(String, GlobalKey<State<StatefulWidget>>)> tabDetails) {
    return tabDetails.asMap().entries.map((entry) {
      final index = entry.key;
      final tabName = entry.value.$1;
      final key = entry.value.$2;

      return InkWell(
        key: key,
        onTap: () {
          haptic(HapticFeedbackType.selection);

          widget._tabController.animateTo(index);
        },
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppSizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                tabName,
                textAlign: TextAlign.left,
                style: context.theme.tabBarTheme.labelStyle?.copyWith(
                  color: _currentIndex == index ? Colors.black : Colors.black54,
                ),
              ),
              const SizedBox(
                height: AppSizes.size2,
              ),
              const Spacer(),
              Container(
                width: getTextWidth(tabName, context),
                height: 2,
                decoration: ShapeDecoration(
                  color: _currentIndex == index
                      ? AppColors.activeTabColor
                      : Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  double getTextWidth(String text, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: context.theme.tabBarTheme.labelStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);

    return textPainter.width;
  }
}
