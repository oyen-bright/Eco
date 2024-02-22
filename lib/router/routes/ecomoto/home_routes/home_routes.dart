import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/home/browse_vehicles/browse_vehicles_view.dart';
import 'package:emr_005/ecomoto/views/home/map_search_screen/map_search_view.dart';
import 'package:emr_005/ecomoto/views/home/view_all_vehicles/all_vehicles_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class Home {
  static final routes = [
    GoRoute(
      path: EcomotoRoutes.home,
      parentNavigatorKey: AppRouter.homeNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const BrowseVehiclesView(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.homeNavigatorKey,
      path: EcomotoRoutes.homeAllVehicles,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const ViewAllVehicles(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.homeNavigatorKey,
      path: EcomotoRoutes.homeMapSearch,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const VehicleSearchMapView(),
          state: state,
        );
      },
    ),
  ];
}
