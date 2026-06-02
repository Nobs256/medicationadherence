// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppNotificationImpl _$$AppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$AppNotificationImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
  type: json['type'] as String,
  referenceId: (json['reference_id'] as num?)?.toInt(),
  referenceTable: json['reference_table'] as String?,
  isRead: _boolFromInt(json['is_read']),
  sentAt: json['sent_at'] as String,
  senderName: json['sender_name'] as String?,
);

Map<String, dynamic> _$$AppNotificationImplToJson(
  _$AppNotificationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'type': instance.type,
  'reference_id': instance.referenceId,
  'reference_table': instance.referenceTable,
  'is_read': instance.isRead,
  'sent_at': instance.sentAt,
  'sender_name': instance.senderName,
};
