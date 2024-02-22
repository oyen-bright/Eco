import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/notification_cubit/notification_cubit.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  final Color? color;
  const NotificationIcon({super.key, this.count = 1, this.color});

  @override
  Widget build(BuildContext context) {
    final notificationCount =
        context.watch<NotificationCubit>().state.notificationCount;
    return Badge(
      isLabelVisible: notificationCount != 0,
      label: Text(notificationCount.toString()),
      offset: const Offset(-7, 7),
      backgroundColor: Colors.red,
      child: IconButton(
          color: color,
          onPressed: () {
            haptic(HapticFeedbackType.selection);

            AppRouter.router.push(EcomotoRoutes.notifications);
          },
          icon: const Icon(
            Icons.notifications_outlined,
          )),
    );
  }
}
