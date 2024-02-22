import 'package:emr_005/ecomoto/cubit/notification_cubit/notification_cubit.dart';
import 'package:emr_005/ecomoto/mixins/ai_price_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_item.dart';

class NotificationBuilder extends StatelessWidget with AiPrice {
  const NotificationBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final notifications = state.notifications;

        return SliverList.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItem(
              onTap: () => _onTap(context, notifications[index].action),
              title: notifications[index].title,
              message: notifications[index].subtitle,
            );
          },
        );
      },
    );
  }

  _onTap(BuildContext context, String? action) {
    if (action == "verify_drivers_license") {
      verifyDriversLicense(context);
    }
  }
}
