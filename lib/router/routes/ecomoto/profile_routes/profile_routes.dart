import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/dashbord_view.dart';
import 'package:emr_005/ecomoto/views/profile/payments/payment_view.dart';
import 'package:emr_005/ecomoto/views/profile/profile/profile_view.dart';
import 'package:emr_005/ecomoto/views/profile/settings/settings_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/utils/subpart_route_util.dart';
import 'package:go_router/go_router.dart';

import 'settings_routes.dart';

class Profile {
  static final routes = [
    GoRoute(
        parentNavigatorKey: AppRouter.profileNavigatorKey,
        path: EcomotoRoutes.profile,
        pageBuilder: (context, state) {
          return AppRouter.setupPage(
            child: const DashboardView(),
            state: state,
          );
        },
        routes: [
          GoRoute(
            path: routeSubPath(EcomotoRoutes.profilePayments),
            pageBuilder: (context, GoRouterState state) {
              return AppRouter.setupPage(
                child: const PaymentView(),
                state: state,
              );
            },
          ),
          GoRoute(
            path: routeSubPath(EcomotoRoutes.profileProfile),
            pageBuilder: (context, GoRouterState state) {
              return AppRouter.setupPage(
                child: const ProfileView(),
                state: state,
              );
            },
          ),
          GoRoute(
              path: routeSubPath(EcomotoRoutes.profileSettings),
              pageBuilder: (context, GoRouterState state) {
                return AppRouter.setupPage(
                  child: const SettingsView(),
                  state: state,
                );
              },
              routes: [...Settings.routes])
        ]),
  ];
}
