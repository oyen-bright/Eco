import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EcobookChat {
  static final routes = [
    GoRoute(
      path: EcoBookRoutes.chat,
      parentNavigatorKey: AppRouter.ecobookChatNavigatorKey,
      pageBuilder: (context, state) {
        return AppRouter.setupPage(
          child: const Center(
            child: Text("Ecobook Chat"),
          ),
          state: state,
        );
      },
    ),
  ];
}
