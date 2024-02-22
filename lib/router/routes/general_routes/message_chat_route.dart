import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/views/message_chat/fullscreen_image.dart';
import 'package:emr_005/ecomoto/views/message_chat/message_chat.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

class MessageChatRoute {
  static final routes = [
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.ecomotoMessageChat,
      pageBuilder: (context, state) {
        final extra = state.extra as List;
        final senderID = extra[0] as String;
        final lessor = extra[1] as Map<String, dynamic>;
        final tripID = extra[2] as String;
        return AppRouter.setupPage(
          child: MessageChatView(
            senderID: senderID,
            lessor: lessor,
            tripID: tripID,
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: AppRouter.parentNavigatorKey,
      path: EcomotoRoutes.ecomotoFullImageView,
      pageBuilder: (context, state) {
        final extra = state.extra as List;
        final imageUrl = extra[0] as String;
        final heroTag = extra[1] as String;
        return AppRouter.setupPage(
          child: FullScreenImageView(
            imageUrl: imageUrl,
            heroTag: heroTag,
          ),
          state: state,
        );
      },
    ),
  ];
}
