import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/trips/trips_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class Trip {
  static final routes = [
    GoRoute(
        parentNavigatorKey: AppRouter.tripNavigatorKey,
        path: EcomotoRoutes.trips,
        pageBuilder: (context, state) {
          return AppRouter.setupPage(
            child: const TripsView(),
            state: state,
          );
        },
        routes: const [
          // GoRoute(
          //   parentNavigatorKey: AppRouter.tripNavigatorKey,
          //   path: routeSubPath(EcomotoRoutes.tripsBookedDetails, levels: 3),
          //   pageBuilder: (context, state) {
          //     final tripDetails = state.extra as trip_model.Trip;

          //     return AppRouter.setupPage(
          //       child: BookedTripDetailsView(
          //         tripDetails: tripDetails,
          //       ),
          //       state: state,
          //     );
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: AppRouter.tripNavigatorKey,
          //   path: routeSubPath(EcomotoRoutes.tripsHistoryDetails, levels: 3),
          //   pageBuilder: (context, state) {
          //     final tripDetails = state.extra as trip_model.Trip;

          //     return AppRouter.setupPage(
          //       child: HistoryTripDetailsView(
          //         tripDetails: tripDetails,
          //       ),
          //       state: state,
          //     );
          //   },
          // ),
        ]),
  ];
}
