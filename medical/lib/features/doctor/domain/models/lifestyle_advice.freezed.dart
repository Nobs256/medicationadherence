// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifestyle_advice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LifestyleAdvice _$LifestyleAdviceFromJson(Map<String, dynamic> json) {
  return _LifestyleAdvice.fromJson(json);
}

/// @nodoc
mixin _$LifestyleAdvice {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
  int get prescriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'advice_type')
  String get adviceType => throw _privateConstructorUsedError; // exercise, diet, hydration, sleep, general
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get frequency => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
  int? get durationMinutes => throw _privateConstructorUsedError;

  /// Serializes this LifestyleAdvice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LifestyleAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LifestyleAdviceCopyWith<LifestyleAdvice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LifestyleAdviceCopyWith<$Res> {
  factory $LifestyleAdviceCopyWith(
    LifestyleAdvice value,
    $Res Function(LifestyleAdvice) then,
  ) = _$LifestyleAdviceCopyWithImpl<$Res, LifestyleAdvice>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
    int prescriptionId,
    @JsonKey(name: 'advice_type') String adviceType,
    String title,
    String description,
    String? frequency,
    @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
    int? durationMinutes,
  });
}

/// @nodoc
class _$LifestyleAdviceCopyWithImpl<$Res, $Val extends LifestyleAdvice>
    implements $LifestyleAdviceCopyWith<$Res> {
  _$LifestyleAdviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LifestyleAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? prescriptionId = null,
    Object? adviceType = null,
    Object? title = null,
    Object? description = null,
    Object? frequency = freezed,
    Object? durationMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            prescriptionId:
                null == prescriptionId
                    ? _value.prescriptionId
                    : prescriptionId // ignore: cast_nullable_to_non_nullable
                        as int,
            adviceType:
                null == adviceType
                    ? _value.adviceType
                    : adviceType // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            frequency:
                freezed == frequency
                    ? _value.frequency
                    : frequency // ignore: cast_nullable_to_non_nullable
                        as String?,
            durationMinutes:
                freezed == durationMinutes
                    ? _value.durationMinutes
                    : durationMinutes // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LifestyleAdviceImplCopyWith<$Res>
    implements $LifestyleAdviceCopyWith<$Res> {
  factory _$$LifestyleAdviceImplCopyWith(
    _$LifestyleAdviceImpl value,
    $Res Function(_$LifestyleAdviceImpl) then,
  ) = __$$LifestyleAdviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
    int prescriptionId,
    @JsonKey(name: 'advice_type') String adviceType,
    String title,
    String description,
    String? frequency,
    @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
    int? durationMinutes,
  });
}

/// @nodoc
class __$$LifestyleAdviceImplCopyWithImpl<$Res>
    extends _$LifestyleAdviceCopyWithImpl<$Res, _$LifestyleAdviceImpl>
    implements _$$LifestyleAdviceImplCopyWith<$Res> {
  __$$LifestyleAdviceImplCopyWithImpl(
    _$LifestyleAdviceImpl _value,
    $Res Function(_$LifestyleAdviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LifestyleAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? prescriptionId = null,
    Object? adviceType = null,
    Object? title = null,
    Object? description = null,
    Object? frequency = freezed,
    Object? durationMinutes = freezed,
  }) {
    return _then(
      _$LifestyleAdviceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        prescriptionId:
            null == prescriptionId
                ? _value.prescriptionId
                : prescriptionId // ignore: cast_nullable_to_non_nullable
                    as int,
        adviceType:
            null == adviceType
                ? _value.adviceType
                : adviceType // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        frequency:
            freezed == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                    as String?,
        durationMinutes:
            freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LifestyleAdviceImpl implements _LifestyleAdvice {
  const _$LifestyleAdviceImpl({
    @JsonKey(fromJson: _intFromJson) required this.id,
    @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
    required this.prescriptionId,
    @JsonKey(name: 'advice_type') required this.adviceType,
    required this.title,
    required this.description,
    this.frequency,
    @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
    this.durationMinutes,
  });

  factory _$LifestyleAdviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$LifestyleAdviceImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
  final int prescriptionId;
  @override
  @JsonKey(name: 'advice_type')
  final String adviceType;
  // exercise, diet, hydration, sleep, general
  @override
  final String title;
  @override
  final String description;
  @override
  final String? frequency;
  @override
  @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
  final int? durationMinutes;

  @override
  String toString() {
    return 'LifestyleAdvice(id: $id, prescriptionId: $prescriptionId, adviceType: $adviceType, title: $title, description: $description, frequency: $frequency, durationMinutes: $durationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LifestyleAdviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.prescriptionId, prescriptionId) ||
                other.prescriptionId == prescriptionId) &&
            (identical(other.adviceType, adviceType) ||
                other.adviceType == adviceType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    prescriptionId,
    adviceType,
    title,
    description,
    frequency,
    durationMinutes,
  );

  /// Create a copy of LifestyleAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LifestyleAdviceImplCopyWith<_$LifestyleAdviceImpl> get copyWith =>
      __$$LifestyleAdviceImplCopyWithImpl<_$LifestyleAdviceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LifestyleAdviceImplToJson(this);
  }
}

abstract class _LifestyleAdvice implements LifestyleAdvice {
  const factory _LifestyleAdvice({
    @JsonKey(fromJson: _intFromJson) required final int id,
    @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
    required final int prescriptionId,
    @JsonKey(name: 'advice_type') required final String adviceType,
    required final String title,
    required final String description,
    final String? frequency,
    @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
    final int? durationMinutes,
  }) = _$LifestyleAdviceImpl;

  factory _LifestyleAdvice.fromJson(Map<String, dynamic> json) =
      _$LifestyleAdviceImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  @JsonKey(name: 'prescription_id', fromJson: _intFromJson)
  int get prescriptionId;
  @override
  @JsonKey(name: 'advice_type')
  String get adviceType; // exercise, diet, hydration, sleep, general
  @override
  String get title;
  @override
  String get description;
  @override
  String? get frequency;
  @override
  @JsonKey(name: 'duration_minutes', fromJson: _intFromDynamic)
  int? get durationMinutes;

  /// Create a copy of LifestyleAdvice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LifestyleAdviceImplCopyWith<_$LifestyleAdviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
