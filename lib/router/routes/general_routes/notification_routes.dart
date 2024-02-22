import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/notification/notification_view.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';

class Notification {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.notifications,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const NotificationView(),
          state: state,
        );
      },
    ),
  ];
}
