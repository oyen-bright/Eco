import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/ecobook_feed_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class EcoBookFeeds {
  static final routes = [
    GoRoute(
      path: EcoBookRoutes.feeds,
      parentNavigatorKey: AppRouter.ecobookFeedsNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const EcobookFeedView(),
          state: state,
        );
      },
    ),
  ];
}
