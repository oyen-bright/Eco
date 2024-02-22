import 'package:flutter/material.dart';

class AuthRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static push(String route, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  static replace(String route, {Object? arguments}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }
}
