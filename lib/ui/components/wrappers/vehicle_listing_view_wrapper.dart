import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

class VehicleListingWrapper extends StatelessWidget {
  final Widget? body;
  final String title;
  final bool showAppBar;
  final bool automaticallyImplyLeading;
  const VehicleListingWrapper(
      {super.key,
      this.body,
      this.showAppBar = true,
      this.title = "",
      this.automaticallyImplyLeading = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              backgroundColor: context.theme.scaffoldBackgroundColor,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: context.colorScheme.onBackground),
              automaticallyImplyLeading: automaticallyImplyLeading,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        top: !showAppBar,
        child: body!,
      ),
    );
  }
}
