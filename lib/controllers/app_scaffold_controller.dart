import 'package:flutter/material.dart';

class AppScaffoldController {
  late final GlobalKey<ScaffoldState> scaffoldKey;
  AppScaffoldController() : scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get key => scaffoldKey;

  void openDrawer() => scaffoldKey.currentState?.openDrawer();
  void openEndDrawer() => scaffoldKey.currentState?.openEndDrawer();

  void closeDrawer() => scaffoldKey.currentState?.closeDrawer();
  void closeEndDrawer() => scaffoldKey.currentState?.closeEndDrawer();
}
