import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/notification_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSliverViewBar extends StatelessWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Object? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool? snap;
  final bool showNotification;

  final double? titleSpacing;
  final double? expandedHeight;
  final double? collapsedHeight;

  final bool floating;
  final bool pinned;

  final double? toolbarHeight;
  final double? leadingWidth;

  final SystemUiOverlayStyle? systemOverlayStyle;

  final EdgeInsets? padding;
  final bool userFlexibleSpace;

  const AppSliverViewBar._internal({
    Key? key,
    this.leading,
    this.snap,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.showNotification = false,
    this.bottom,
    this.userFlexibleSpace = false,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing,
    this.expandedHeight,
    this.collapsedHeight = kToolbarHeight,
    this.floating = false,
    this.pinned = false,
    this.toolbarHeight,
    this.leadingWidth,
    this.systemOverlayStyle,
    this.padding,
  });

  factory AppSliverViewBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Object? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool primary = true,
    bool snap = false,
    bool? centerTitle,
    double? titleSpacing,
    double? expandedHeight,
    double? collapsedHeight = kToolbarHeight,
    bool floating = false,
    bool pinned = false,
    double? toolbarHeight,
    double? leadingWidth,
    SystemUiOverlayStyle? systemOverlayStyle,
    Clip? clipBehavior,
  }) {
    return AppSliverViewBar._internal(
      key: key,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      snap: snap,
      elevation: null,
      padding: null,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      floating: floating,
      pinned: pinned,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  factory AppSliverViewBar.flexibleSpaceBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Object? title,
    List<Widget> actions = const [],
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool primary = true,
    bool snap = false,
    bool? centerTitle,
    double? titleSpacing,
    double? expandedHeight,
    bool? userFlexibleSpace,
    double collapsedHeight = kToolbarHeight,
    bool floating = false,
    bool pinned = false,
    bool showNotification = false,
    double? toolbarHeight,
    double? leadingWidth,
    SystemUiOverlayStyle? systemOverlayStyle,
    Clip? clipBehavior,
  }) {
    return AppSliverViewBar._internal(
      key: key,
      showNotification: showNotification,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      snap: snap,
      elevation: null,
      padding: null,
      userFlexibleSpace: userFlexibleSpace ?? true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      floating: floating,
      pinned: pinned,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> actionWithNotification = [
      ...?actions,
      if (showNotification)
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 5),
            child: NotificationIcon(),
          ),
        ),
    ];
    return SliverAppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: !userFlexibleSpace ? _getTitleWidget(context) : null,
      actions: actionWithNotification,
      flexibleSpace: userFlexibleSpace
          ? flexibleSpace ?? _getFlexibleSpaceBar(context)
          : null,
      bottom: bottom,
      elevation: elevation,
      snap: snap ?? false,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      floating: floating,
      pinned: pinned,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget? _getTitleWidget(BuildContext context) {
    if (title is Widget) {
      return title as Widget?;
    } else if (title is String) {
      return Text(
        title as String,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.bold),
      );
    }
    return null;
  }

  Widget? _getFlexibleSpaceBar(BuildContext context) {
    if (title is String) {
      return FlexibleSpaceBar(
        centerTitle: centerTitle ?? false,
        titlePadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        title: Text(
          title as String,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      );
    }
    return null;
  }
}
