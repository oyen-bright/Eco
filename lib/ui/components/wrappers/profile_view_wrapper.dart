import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';

class ProfileViewWrapper extends StatelessWidget {
  final String? title;
  final List<Widget> actions;
  final Widget body;
  final Widget? titleWidget;
  final Widget? background;
  final Color? backgroundColor;
  final bool useSliver;
  final bool? automaticallyImplyLeading;

  const ProfileViewWrapper._(
      {required this.title,
      required this.actions,
      required this.body,
      required this.titleWidget,
      this.background,
      this.backgroundColor,
      this.useSliver = false,
      this.automaticallyImplyLeading = false});

  factory ProfileViewWrapper({
    required String title,
    List<Widget> actions = const [],
    required Widget body,
    Widget? background,
    bool useSliver = false,
    bool? automaticallyImplyLeading,
    Color? backgroundColor,
  }) {
    return ProfileViewWrapper._(
      title: title,
      titleWidget: null,
      actions: actions,
      useSliver: useSliver,
      body: body,
      background: background,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor,
    );
  }

  factory ProfileViewWrapper.withTitleWidget({
    List<Widget> actions = const [],
    required Widget body,
    Widget? background,
    Color? backgroundColor,
    required Widget titleWidget,
  }) {
    return ProfileViewWrapper._(
      title: null,
      titleWidget: titleWidget,
      actions: actions,
      body: body,
      background: background,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: backgroundColor ?? context.colorScheme.primary,
            automaticallyImplyLeading: automaticallyImplyLeading ?? false,
            foregroundColor:
                backgroundColor != null ? null : context.colorScheme.onPrimary,
            actions: actions,
            collapsedHeight: 80,
            expandedHeight: 150.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.fadeTitle],
              centerTitle: false,
              titlePadding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingHorizontal, vertical: 15),
              title: titleWidget ??
                  Text(
                    title!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              background: background ??
                  Image.asset(
                    AppImages.profileHeaderBGImage,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          if (useSliver)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingHorizontal,
                  vertical: AppConstants.viewPaddingVertical),
              sliver: body,
            )
          else
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingHorizontal,
              ),
              child: body,
            )),
        ],
      ),
    );
  }
}
