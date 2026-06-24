// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_id', fromJson: _intFromAny)
  int? get referenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_table')
  String? get referenceTable => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read', fromJson: _boolFromInt)
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_at')
  String get sentAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_name')
  String? get senderName => throw _privateConstructorUsedError;

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
    AppNotification value,
    $Res Function(AppNotification) then,
  ) = _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call({
    int id,
    String title,
    String body,
    String type,
    @JsonKey(name: 'reference_id', fromJson: _intFromAny) int? referenceId,
    @JsonKey(name: 'reference_table') String? referenceTable,
    @JsonKey(name: 'is_read', fromJson: _boolFromInt) bool isRead,
    @JsonKey(name: 'sent_at') String sentAt,
    @JsonKey(name: 'sender_name') String? senderName,
  });
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? referenceId = freezed,
    Object? referenceTable = freezed,
    Object? isRead = null,
    Object? sentAt = null,
    Object? senderName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            body:
                null == body
                    ? _value.body
                    : body // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            referenceId:
                freezed == referenceId
                    ? _value.referenceId
                    : referenceId // ignore: cast_nullable_to_non_nullable
                        as int?,
            referenceTable:
                freezed == referenceTable
                    ? _value.referenceTable
                    : referenceTable // ignore: cast_nullable_to_non_nullable
                        as String?,
            isRead:
                null == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool,
            sentAt:
                null == sentAt
                    ? _value.sentAt
                    : sentAt // ignore: cast_nullable_to_non_nullable
                        as String,
            senderName:
                freezed == senderName
                    ? _value.senderName
                    : senderName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(
    _$AppNotificationImpl value,
    $Res Function(_$AppNotificationImpl) then,
  ) = __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String body,
    String type,
    @JsonKey(name: 'reference_id', fromJson: _intFromAny) int? referenceId,
    @JsonKey(name: 'reference_table') String? referenceTable,
    @JsonKey(name: 'is_read', fromJson: _boolFromInt) bool isRead,
    @JsonKey(name: 'sent_at') String sentAt,
    @JsonKey(name: 'sender_name') String? senderName,
  });
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
    _$AppNotificationImpl _value,
    $Res Function(_$AppNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? referenceId = freezed,
    Object? referenceTable = freezed,
    Object? isRead = null,
    Object? sentAt = null,
    Object? senderName = freezed,
  }) {
    return _then(
      _$AppNotificationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        body:
            null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        referenceId:
            freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                    as int?,
        referenceTable:
            freezed == referenceTable
                ? _value.referenceTable
                : referenceTable // ignore: cast_nullable_to_non_nullable
                    as String?,
        isRead:
            null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool,
        sentAt:
            null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                    as String,
        senderName:
            freezed == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    @JsonKey(name: 'reference_id', fromJson: _intFromAny) this.referenceId,
    @JsonKey(name: 'reference_table') this.referenceTable,
    @JsonKey(name: 'is_read', fromJson: _boolFromInt) required this.isRead,
    @JsonKey(name: 'sent_at') required this.sentAt,
    @JsonKey(name: 'sender_name') this.senderName,
  });

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
  @override
  @JsonKey(name: 'reference_id', fromJson: _intFromAny)
  final int? referenceId;
  @override
  @JsonKey(name: 'reference_table')
  final String? referenceTable;
  @override
  @JsonKey(name: 'is_read', fromJson: _boolFromInt)
  final bool isRead;
  @override
  @JsonKey(name: 'sent_at')
  final String sentAt;
  @override
  @JsonKey(name: 'sender_name')
  final String? senderName;

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, body: $body, type: $type, referenceId: $referenceId, referenceTable: $referenceTable, isRead: $isRead, sentAt: $sentAt, senderName: $senderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceTable, referenceTable) ||
                other.referenceTable == referenceTable) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    body,
    type,
    referenceId,
    referenceTable,
    isRead,
    sentAt,
    senderName,
  );

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(this);
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification({
    required final int id,
    required final String title,
    required final String body,
    required final String type,
    @JsonKey(name: 'reference_id', fromJson: _intFromAny)
    final int? referenceId,
    @JsonKey(name: 'reference_table') final String? referenceTable,
    @JsonKey(name: 'is_read', fromJson: _boolFromInt)
    required final bool isRead,
    @JsonKey(name: 'sent_at') required final String sentAt,
    @JsonKey(name: 'sender_name') final String? senderName,
  }) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get type;
  @override
  @JsonKey(name: 'reference_id', fromJson: _intFromAny)
  int? get referenceId;
  @override
  @JsonKey(name: 'reference_table')
  String? get referenceTable;
  @override
  @JsonKey(name: 'is_read', fromJson: _boolFromInt)
  bool get isRead;
  @override
  @JsonKey(name: 'sent_at')
  String get sentAt;
  @override
  @JsonKey(name: 'sender_name')
  String? get senderName;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
