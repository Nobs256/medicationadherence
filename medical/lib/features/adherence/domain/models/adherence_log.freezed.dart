// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adherence_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdherenceLog _$AdherenceLogFromJson(Map<String, dynamic> json) {
  return _AdherenceLog.fromJson(json);
}

/// @nodoc
mixin _$AdherenceLog {
  @JsonKey(name: 'log_date')
  String get logDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_scheduled')
  int get totalScheduled => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_taken')
  int get totalTaken => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_missed')
  int get totalMissed => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_skipped')
  int get totalSkipped => throw _privateConstructorUsedError;
  @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
  double get adherencePercentage => throw _privateConstructorUsedError;

  /// Serializes this AdherenceLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdherenceLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdherenceLogCopyWith<AdherenceLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdherenceLogCopyWith<$Res> {
  factory $AdherenceLogCopyWith(
    AdherenceLog value,
    $Res Function(AdherenceLog) then,
  ) = _$AdherenceLogCopyWithImpl<$Res, AdherenceLog>;
  @useResult
  $Res call({
    @JsonKey(name: 'log_date') String logDate,
    @JsonKey(name: 'total_scheduled') int totalScheduled,
    @JsonKey(name: 'total_taken') int totalTaken,
    @JsonKey(name: 'total_missed') int totalMissed,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
    double adherencePercentage,
  });
}

/// @nodoc
class _$AdherenceLogCopyWithImpl<$Res, $Val extends AdherenceLog>
    implements $AdherenceLogCopyWith<$Res> {
  _$AdherenceLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdherenceLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logDate = null,
    Object? totalScheduled = null,
    Object? totalTaken = null,
    Object? totalMissed = null,
    Object? totalSkipped = null,
    Object? adherencePercentage = null,
  }) {
    return _then(
      _value.copyWith(
            logDate:
                null == logDate
                    ? _value.logDate
                    : logDate // ignore: cast_nullable_to_non_nullable
                        as String,
            totalScheduled:
                null == totalScheduled
                    ? _value.totalScheduled
                    : totalScheduled // ignore: cast_nullable_to_non_nullable
                        as int,
            totalTaken:
                null == totalTaken
                    ? _value.totalTaken
                    : totalTaken // ignore: cast_nullable_to_non_nullable
                        as int,
            totalMissed:
                null == totalMissed
                    ? _value.totalMissed
                    : totalMissed // ignore: cast_nullable_to_non_nullable
                        as int,
            totalSkipped:
                null == totalSkipped
                    ? _value.totalSkipped
                    : totalSkipped // ignore: cast_nullable_to_non_nullable
                        as int,
            adherencePercentage:
                null == adherencePercentage
                    ? _value.adherencePercentage
                    : adherencePercentage // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdherenceLogImplCopyWith<$Res>
    implements $AdherenceLogCopyWith<$Res> {
  factory _$$AdherenceLogImplCopyWith(
    _$AdherenceLogImpl value,
    $Res Function(_$AdherenceLogImpl) then,
  ) = __$$AdherenceLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'log_date') String logDate,
    @JsonKey(name: 'total_scheduled') int totalScheduled,
    @JsonKey(name: 'total_taken') int totalTaken,
    @JsonKey(name: 'total_missed') int totalMissed,
    @JsonKey(name: 'total_skipped') int totalSkipped,
    @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
    double adherencePercentage,
  });
}

/// @nodoc
class __$$AdherenceLogImplCopyWithImpl<$Res>
    extends _$AdherenceLogCopyWithImpl<$Res, _$AdherenceLogImpl>
    implements _$$AdherenceLogImplCopyWith<$Res> {
  __$$AdherenceLogImplCopyWithImpl(
    _$AdherenceLogImpl _value,
    $Res Function(_$AdherenceLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdherenceLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logDate = null,
    Object? totalScheduled = null,
    Object? totalTaken = null,
    Object? totalMissed = null,
    Object? totalSkipped = null,
    Object? adherencePercentage = null,
  }) {
    return _then(
      _$AdherenceLogImpl(
        logDate:
            null == logDate
                ? _value.logDate
                : logDate // ignore: cast_nullable_to_non_nullable
                    as String,
        totalScheduled:
            null == totalScheduled
                ? _value.totalScheduled
                : totalScheduled // ignore: cast_nullable_to_non_nullable
                    as int,
        totalTaken:
            null == totalTaken
                ? _value.totalTaken
                : totalTaken // ignore: cast_nullable_to_non_nullable
                    as int,
        totalMissed:
            null == totalMissed
                ? _value.totalMissed
                : totalMissed // ignore: cast_nullable_to_non_nullable
                    as int,
        totalSkipped:
            null == totalSkipped
                ? _value.totalSkipped
                : totalSkipped // ignore: cast_nullable_to_non_nullable
                    as int,
        adherencePercentage:
            null == adherencePercentage
                ? _value.adherencePercentage
                : adherencePercentage // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdherenceLogImpl implements _AdherenceLog {
  const _$AdherenceLogImpl({
    @JsonKey(name: 'log_date') required this.logDate,
    @JsonKey(name: 'total_scheduled') required this.totalScheduled,
    @JsonKey(name: 'total_taken') required this.totalTaken,
    @JsonKey(name: 'total_missed') required this.totalMissed,
    @JsonKey(name: 'total_skipped') required this.totalSkipped,
    @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
    required this.adherencePercentage,
  });

  factory _$AdherenceLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdherenceLogImplFromJson(json);

  @override
  @JsonKey(name: 'log_date')
  final String logDate;
  @override
  @JsonKey(name: 'total_scheduled')
  final int totalScheduled;
  @override
  @JsonKey(name: 'total_taken')
  final int totalTaken;
  @override
  @JsonKey(name: 'total_missed')
  final int totalMissed;
  @override
  @JsonKey(name: 'total_skipped')
  final int totalSkipped;
  @override
  @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
  final double adherencePercentage;

  @override
  String toString() {
    return 'AdherenceLog(logDate: $logDate, totalScheduled: $totalScheduled, totalTaken: $totalTaken, totalMissed: $totalMissed, totalSkipped: $totalSkipped, adherencePercentage: $adherencePercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdherenceLogImpl &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.totalScheduled, totalScheduled) ||
                other.totalScheduled == totalScheduled) &&
            (identical(other.totalTaken, totalTaken) ||
                other.totalTaken == totalTaken) &&
            (identical(other.totalMissed, totalMissed) ||
                other.totalMissed == totalMissed) &&
            (identical(other.totalSkipped, totalSkipped) ||
                other.totalSkipped == totalSkipped) &&
            (identical(other.adherencePercentage, adherencePercentage) ||
                other.adherencePercentage == adherencePercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    logDate,
    totalScheduled,
    totalTaken,
    totalMissed,
    totalSkipped,
    adherencePercentage,
  );

  /// Create a copy of AdherenceLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdherenceLogImplCopyWith<_$AdherenceLogImpl> get copyWith =>
      __$$AdherenceLogImplCopyWithImpl<_$AdherenceLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdherenceLogImplToJson(this);
  }
}

abstract class _AdherenceLog implements AdherenceLog {
  const factory _AdherenceLog({
    @JsonKey(name: 'log_date') required final String logDate,
    @JsonKey(name: 'total_scheduled') required final int totalScheduled,
    @JsonKey(name: 'total_taken') required final int totalTaken,
    @JsonKey(name: 'total_missed') required final int totalMissed,
    @JsonKey(name: 'total_skipped') required final int totalSkipped,
    @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
    required final double adherencePercentage,
  }) = _$AdherenceLogImpl;

  factory _AdherenceLog.fromJson(Map<String, dynamic> json) =
      _$AdherenceLogImpl.fromJson;

  @override
  @JsonKey(name: 'log_date')
  String get logDate;
  @override
  @JsonKey(name: 'total_scheduled')
  int get totalScheduled;
  @override
  @JsonKey(name: 'total_taken')
  int get totalTaken;
  @override
  @JsonKey(name: 'total_missed')
  int get totalMissed;
  @override
  @JsonKey(name: 'total_skipped')
  int get totalSkipped;
  @override
  @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
  double get adherencePercentage;

  /// Create a copy of AdherenceLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdherenceLogImplCopyWith<_$AdherenceLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
