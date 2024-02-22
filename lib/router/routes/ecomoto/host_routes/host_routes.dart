import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/host/host_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class Host {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.hostNavigatorKey,
      path: EcomotoRoutes.host,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const HostView(),
          state: state,
        );
      },
    ),
  ];
}
