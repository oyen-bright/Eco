import 'dart:async';

import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_model.dart';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final UserCubit userCubit;
  late final StreamSubscription userCubitSubscription;

  NotificationCubit(this.userCubit) : super(const NotificationState()) {
    userCubitSubscription = userCubit.stream.listen((userState) {
      _handleUserStateNotifications(userState);
    });
  }

  void _handleUserStateNotifications(UserState userState) {
    if (userState.user.userOnboardingStatus == null ||
        userState.user.userOnboardingStatus == UserOnboardingStatus.setKyc) {
      _promptForDriverLicenseVerification();
    } else if (userState.user.userOnboardingStatus ==
        UserOnboardingStatus.verifyDriverLicense) {
      _removeDriverLicenseNotification();
    }
  }

  void _promptForDriverLicenseVerification() {
    const newNotification = NotificationModel(
        action: "verify_drivers_license",
        title: "Verify Your Driver's License",
        subtitle:
            "To rent or list vehicles, please verify your driver's license.");
    addNotification(newNotification);
  }

  void _removeDriverLicenseNotification() {
    try {
      final notificationToRemove = (state.notifications).firstWhere(
        (n) => n.action == "verify_drivers_license",
      );

      removeNotification(notificationToRemove);
    } catch (e) {
      return;
    }
  }

  void addNotification(NotificationModel notification) {
    final updatedNotifications =
        List<NotificationModel>.from(state.notifications)..add(notification);
    emit(state.copyWith(notifications: updatedNotifications));
  }

  void removeNotification(NotificationModel notification) {
    final updatedNotifications =
        state.notifications.where((n) => n != notification).toList();
    emit(state.copyWith(notifications: updatedNotifications));
  }

  @override
  Future<void> close() {
    userCubitSubscription.cancel();
    return super.close();
  }
}
