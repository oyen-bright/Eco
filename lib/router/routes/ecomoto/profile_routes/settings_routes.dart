import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/profile/settings/change_email/change_email_view.dart';
import 'package:emr_005/ecomoto/views/profile/settings/change_password/change_password_view.dart';
import 'package:emr_005/ecomoto/views/profile/settings/general_settings/general_settings_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/utils/subpart_route_util.dart';
import 'package:go_router/go_router.dart';

class Settings {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.profileNavigatorKey,
      path: routeSubPath(EcomotoRoutes.profileSettingsGeneral, levels: 3),
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const GeneralSettingsView(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.profileNavigatorKey,
      path: routeSubPath(EcomotoRoutes.profileSettingPassword, levels: 3),
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const ChangePasswordView(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.profileNavigatorKey,
      path: routeSubPath(EcomotoRoutes.profileSettingsEmail, levels: 3),
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const ChangeEmailView(),
          state: state,
        );
      },
    ),
  ];
}
