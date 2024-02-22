import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String title,
    required String subtitle,
    String? action,
    dynamic payload,
  }) = _NotificationModel;
}
