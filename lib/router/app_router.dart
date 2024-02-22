import 'dart:developer';

import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/router/routes/ecobook/chat_routes/routes.dart';
import 'package:emr_005/router/routes/ecobook/community_routes/community_routes.dart';
import 'package:emr_005/router/routes/ecobook/feeds_routes/feed_routes.dart';
import 'package:emr_005/router/routes/ecobook/profile_routes/routes.dart';
import 'package:emr_005/router/routes/ecomoto/trips_routes/trip_routes.dart';
import 'package:emr_005/router/routes/general_routes/general_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/views/bottom_navigator/bottom_navigator.dart';
import 'routes/ecomoto/home_routes/home_routes.dart';
import 'routes/ecomoto/host_routes/host_routes.dart';
import 'routes/ecomoto/profile_routes/profile_routes.dart';

class AppRouter {
  factory AppRouter() {
    return _instance;
  }

  static Page setupPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  static final AppRouter _instance = AppRouter._internal();
  static AppRouter get instance => _instance;
  static GlobalKey<NavigatorState> get generateNavigatorKey =>
      GlobalKey<NavigatorState>();

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      AppRouter.generateNavigatorKey;

  static final GlobalKey<NavigatorState> homeNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> tripNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> hostNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> profileNavigatorKey =
      AppRouter.generateNavigatorKey;

  static final GlobalKey<NavigatorState> ecobookFeedsNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> ecobookChatNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> ecoBookCommunityNavigatorKey =
      AppRouter.generateNavigatorKey;
  static final GlobalKey<NavigatorState> ecobookProfileNavigatorKey =
      AppRouter.generateNavigatorKey;

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  AppRouter._internal() {
    final routes = [
      _shellRoutes(),
      ...GeneralRoutes.routes,
    ];
    router = GoRouter(
      // observers: [MyAppRouteObserver()],
      navigatorKey: parentNavigatorKey,
      initialLocation: AppRoutes.splash,
      routes: routes,
    );

    log("Initialized", name: "Router");
  }

  StatefulShellRoute _shellRoutes() {
    return StatefulShellRoute.indexedStack(
      parentNavigatorKey: parentNavigatorKey,
      branches: [
        //Ecomoto
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: Home.routes,
        ),
        StatefulShellBranch(
          navigatorKey: tripNavigatorKey,
          routes: Trip.routes,
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
                path: EcoBookRoutes.root,
                redirect: (_, __) => EcoBookRoutes.feeds)
          ],
        ),
        StatefulShellBranch(
          navigatorKey: hostNavigatorKey,
          routes: Host.routes,
        ),
        StatefulShellBranch(
          navigatorKey: profileNavigatorKey,
          routes: Profile.routes,
        ),

        //EcoBook

        StatefulShellBranch(
          navigatorKey: ecobookFeedsNavigatorKey,
          routes: EcoBookFeeds.routes,
        ),
        StatefulShellBranch(
          navigatorKey: ecobookChatNavigatorKey,
          routes: EcobookChat.routes,
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: EcomotoRoutes.root,
                redirect: (_, __) => EcomotoRoutes.home)
          ],
        ),
        StatefulShellBranch(
          navigatorKey: ecoBookCommunityNavigatorKey,
          routes: EcobookCommunity.routes,
        ),

        StatefulShellBranch(
            navigatorKey: ecobookProfileNavigatorKey,
            routes: EcobookProfile.routes,),
      ],
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return setupPage(
          child: AppBottomNavigator(
            child: navigationShell,
          ),
          state: state,
        );
      },
    );
  }
}

// StatefulShellBranch(
//           navigatorKey: route['key'],
//           routes: [
//             GoRoute(
//               routes: route['routes'] ?? [],
//               path: route['path'],
//               pageBuilder: (context, GoRouterState state) {
//                 return setupPage(
//                   child: route['view'],
//                   state: state,
//                 );
//               },
//             ),
//           ],
//         )


