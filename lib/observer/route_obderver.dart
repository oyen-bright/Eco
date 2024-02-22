import 'dart:developer';

import 'package:flutter/material.dart';

class MyAppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    log('Route pushed: ${route.settings}', name: 'Route Observer');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    log('Route popped: ${previousRoute?.settings}', name: 'Route Observer');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    log('Route replaced: ${newRoute?.settings}', name: 'Route Observer');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    log('Route removed: ${route.settings}', name: 'Route Observer');
  }
}
