part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const NotificationState._();
  const factory NotificationState({
    @Default(false) bool isLoading,
    @Default([]) List<NotificationModel> notifications,
  }) = _NotificationState;

  int get notificationCount => notifications.length;
}
