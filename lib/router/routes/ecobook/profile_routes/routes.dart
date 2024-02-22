import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';
import '../../../../ecobook/views/ecobook_profile/ecobook_profile_view.dart';

class EcobookProfile {
  static final routes = [
    GoRoute(
      path: EcoBookRoutes.profile,
      parentNavigatorKey: AppRouter.ecobookProfileNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child:  const EcobookProfileView(),
          state: state,
        );
      },
    ),
  ];
}
