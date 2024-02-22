import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/views/trips/booked_trips_details_view.dart';
import 'package:emr_005/ecomoto/views/trips/history_trip_details.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class Trips {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.tripsBookedDetails,
      pageBuilder: (context, state) {
        final tripDetails = state.extra as Trip;

        return AppRouter.setupPage(
          child: BookedTripDetailsView(
            tripDetails: tripDetails,
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.tripsHistoryDetails,
      pageBuilder: (context, state) {
        final tripDetails = state.extra as Trip;

        return AppRouter.setupPage(
          child: HistoryTripDetailsView(
            tripDetails: tripDetails,
          ),
          state: state,
        );
      },
    ),
  ];
}
