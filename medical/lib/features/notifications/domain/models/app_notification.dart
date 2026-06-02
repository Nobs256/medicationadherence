import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required String title,
    required String body,
    required String type,
    @JsonKey(name: 'reference_id') int? referenceId,
    @JsonKey(name: 'reference_table') String? referenceTable,
    @JsonKey(name: 'is_read', fromJson: _boolFromInt) required bool isRead,
    @JsonKey(name: 'sent_at') required String sentAt,
    @JsonKey(name: 'sender_name') String? senderName,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

bool _boolFromInt(dynamic val) => val == 1 || val == true || val == "1";
