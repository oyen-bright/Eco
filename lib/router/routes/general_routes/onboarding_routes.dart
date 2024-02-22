import 'package:emr_005/config/app_config.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../ecomoto/views/home/home_onboarding/rental_onboarding_view.dart';
import '../../../ui/views/onboarding/onboarding_view.dart';
import '../../../ui/views/splash/splash_view.dart';

class Onboarding {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.splash,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const SplashView(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: AppRoutes.onBoarding,
      redirect: (_, state) {
        if (AppConfig.finishedOnboarding) {
          return AppRoutes.login;
        }
        return null;
      },
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const OnBoardingView(),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.homeOnboarding,
      redirect: (_, state) {
        if (AppConfig.finishedHomeOnboarding) {
          return EcomotoRoutes.home;
        }
        return null;
      },
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const HomeOnboardingView(),
          state: state,
        );
      },
    ),
  ];
}
