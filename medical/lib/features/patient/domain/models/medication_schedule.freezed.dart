// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MedicationSchedule _$MedicationScheduleFromJson(Map<String, dynamic> json) {
  return _MedicationSchedule.fromJson(json);
}

/// @nodoc
mixin _$MedicationSchedule {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_time')
  String get scheduledTime => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, taken, missed, skipped
  @JsonKey(name: 'confirmed_at')
  String? get confirmedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_name')
  String get medicationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withFood => throw _privateConstructorUsedError;
  @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withWater => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_instructions')
  String? get specialInstructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
  int? get prescriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_name')
  String? get doctorName => throw _privateConstructorUsedError;
  String? get diagnosis => throw _privateConstructorUsedError;
  @JsonKey(name: 'lifestyle_tips')
  List<Map<String, String>>? get lifestyleTips =>
      throw _privateConstructorUsedError;

  /// Serializes this MedicationSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationScheduleCopyWith<MedicationSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationScheduleCopyWith<$Res> {
  factory $MedicationScheduleCopyWith(
    MedicationSchedule value,
    $Res Function(MedicationSchedule) then,
  ) = _$MedicationScheduleCopyWithImpl<$Res, MedicationSchedule>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'scheduled_time') String scheduledTime,
    String status,
    @JsonKey(name: 'confirmed_at') String? confirmedAt,
    String? notes,
    String dosage,
    @JsonKey(name: 'medication_name') String medicationName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
    int? prescriptionId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    String? diagnosis,
    @JsonKey(name: 'lifestyle_tips') List<Map<String, String>>? lifestyleTips,
  });
}

/// @nodoc
class _$MedicationScheduleCopyWithImpl<$Res, $Val extends MedicationSchedule>
    implements $MedicationScheduleCopyWith<$Res> {
  _$MedicationScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledTime = null,
    Object? status = null,
    Object? confirmedAt = freezed,
    Object? notes = freezed,
    Object? dosage = null,
    Object? medicationName = null,
    Object? imageUrl = freezed,
    Object? withFood = null,
    Object? withWater = null,
    Object? specialInstructions = freezed,
    Object? prescriptionId = freezed,
    Object? doctorName = freezed,
    Object? diagnosis = freezed,
    Object? lifestyleTips = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            scheduledTime:
                null == scheduledTime
                    ? _value.scheduledTime
                    : scheduledTime // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            confirmedAt:
                freezed == confirmedAt
                    ? _value.confirmedAt
                    : confirmedAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            notes:
                freezed == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String?,
            dosage:
                null == dosage
                    ? _value.dosage
                    : dosage // ignore: cast_nullable_to_non_nullable
                        as String,
            medicationName:
                null == medicationName
                    ? _value.medicationName
                    : medicationName // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            withFood:
                null == withFood
                    ? _value.withFood
                    : withFood // ignore: cast_nullable_to_non_nullable
                        as bool,
            withWater:
                null == withWater
                    ? _value.withWater
                    : withWater // ignore: cast_nullable_to_non_nullable
                        as bool,
            specialInstructions:
                freezed == specialInstructions
                    ? _value.specialInstructions
                    : specialInstructions // ignore: cast_nullable_to_non_nullable
                        as String?,
            prescriptionId:
                freezed == prescriptionId
                    ? _value.prescriptionId
                    : prescriptionId // ignore: cast_nullable_to_non_nullable
                        as int?,
            doctorName:
                freezed == doctorName
                    ? _value.doctorName
                    : doctorName // ignore: cast_nullable_to_non_nullable
                        as String?,
            diagnosis:
                freezed == diagnosis
                    ? _value.diagnosis
                    : diagnosis // ignore: cast_nullable_to_non_nullable
                        as String?,
            lifestyleTips:
                freezed == lifestyleTips
                    ? _value.lifestyleTips
                    : lifestyleTips // ignore: cast_nullable_to_non_nullable
                        as List<Map<String, String>>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MedicationScheduleImplCopyWith<$Res>
    implements $MedicationScheduleCopyWith<$Res> {
  factory _$$MedicationScheduleImplCopyWith(
    _$MedicationScheduleImpl value,
    $Res Function(_$MedicationScheduleImpl) then,
  ) = __$$MedicationScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'scheduled_time') String scheduledTime,
    String status,
    @JsonKey(name: 'confirmed_at') String? confirmedAt,
    String? notes,
    String dosage,
    @JsonKey(name: 'medication_name') String medicationName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
    int? prescriptionId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    String? diagnosis,
    @JsonKey(name: 'lifestyle_tips') List<Map<String, String>>? lifestyleTips,
  });
}

/// @nodoc
class __$$MedicationScheduleImplCopyWithImpl<$Res>
    extends _$MedicationScheduleCopyWithImpl<$Res, _$MedicationScheduleImpl>
    implements _$$MedicationScheduleImplCopyWith<$Res> {
  __$$MedicationScheduleImplCopyWithImpl(
    _$MedicationScheduleImpl _value,
    $Res Function(_$MedicationScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledTime = null,
    Object? status = null,
    Object? confirmedAt = freezed,
    Object? notes = freezed,
    Object? dosage = null,
    Object? medicationName = null,
    Object? imageUrl = freezed,
    Object? withFood = null,
    Object? withWater = null,
    Object? specialInstructions = freezed,
    Object? prescriptionId = freezed,
    Object? doctorName = freezed,
    Object? diagnosis = freezed,
    Object? lifestyleTips = freezed,
  }) {
    return _then(
      _$MedicationScheduleImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        scheduledTime:
            null == scheduledTime
                ? _value.scheduledTime
                : scheduledTime // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        confirmedAt:
            freezed == confirmedAt
                ? _value.confirmedAt
                : confirmedAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        notes:
            freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String?,
        dosage:
            null == dosage
                ? _value.dosage
                : dosage // ignore: cast_nullable_to_non_nullable
                    as String,
        medicationName:
            null == medicationName
                ? _value.medicationName
                : medicationName // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        withFood:
            null == withFood
                ? _value.withFood
                : withFood // ignore: cast_nullable_to_non_nullable
                    as bool,
        withWater:
            null == withWater
                ? _value.withWater
                : withWater // ignore: cast_nullable_to_non_nullable
                    as bool,
        specialInstructions:
            freezed == specialInstructions
                ? _value.specialInstructions
                : specialInstructions // ignore: cast_nullable_to_non_nullable
                    as String?,
        prescriptionId:
            freezed == prescriptionId
                ? _value.prescriptionId
                : prescriptionId // ignore: cast_nullable_to_non_nullable
                    as int?,
        doctorName:
            freezed == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                    as String?,
        diagnosis:
            freezed == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                    as String?,
        lifestyleTips:
            freezed == lifestyleTips
                ? _value._lifestyleTips
                : lifestyleTips // ignore: cast_nullable_to_non_nullable
                    as List<Map<String, String>>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationScheduleImpl implements _MedicationSchedule {
  const _$MedicationScheduleImpl({
    @JsonKey(fromJson: _intFromJson) required this.id,
    @JsonKey(name: 'scheduled_time') required this.scheduledTime,
    required this.status,
    @JsonKey(name: 'confirmed_at') this.confirmedAt,
    this.notes,
    required this.dosage,
    @JsonKey(name: 'medication_name') required this.medicationName,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required this.withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required this.withWater,
    @JsonKey(name: 'special_instructions') this.specialInstructions,
    @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
    this.prescriptionId,
    @JsonKey(name: 'doctor_name') this.doctorName,
    this.diagnosis,
    @JsonKey(name: 'lifestyle_tips')
    final List<Map<String, String>>? lifestyleTips,
  }) : _lifestyleTips = lifestyleTips;

  factory _$MedicationScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationScheduleImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  @JsonKey(name: 'scheduled_time')
  final String scheduledTime;
  @override
  final String status;
  // pending, taken, missed, skipped
  @override
  @JsonKey(name: 'confirmed_at')
  final String? confirmedAt;
  @override
  final String? notes;
  @override
  final String dosage;
  @override
  @JsonKey(name: 'medication_name')
  final String medicationName;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool withFood;
  @override
  @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool withWater;
  @override
  @JsonKey(name: 'special_instructions')
  final String? specialInstructions;
  @override
  @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
  final int? prescriptionId;
  @override
  @JsonKey(name: 'doctor_name')
  final String? doctorName;
  @override
  final String? diagnosis;
  final List<Map<String, String>>? _lifestyleTips;
  @override
  @JsonKey(name: 'lifestyle_tips')
  List<Map<String, String>>? get lifestyleTips {
    final value = _lifestyleTips;
    if (value == null) return null;
    if (_lifestyleTips is EqualUnmodifiableListView) return _lifestyleTips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MedicationSchedule(id: $id, scheduledTime: $scheduledTime, status: $status, confirmedAt: $confirmedAt, notes: $notes, dosage: $dosage, medicationName: $medicationName, imageUrl: $imageUrl, withFood: $withFood, withWater: $withWater, specialInstructions: $specialInstructions, prescriptionId: $prescriptionId, doctorName: $doctorName, diagnosis: $diagnosis, lifestyleTips: $lifestyleTips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.medicationName, medicationName) ||
                other.medicationName == medicationName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.withFood, withFood) ||
                other.withFood == withFood) &&
            (identical(other.withWater, withWater) ||
                other.withWater == withWater) &&
            (identical(other.specialInstructions, specialInstructions) ||
                other.specialInstructions == specialInstructions) &&
            (identical(other.prescriptionId, prescriptionId) ||
                other.prescriptionId == prescriptionId) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            const DeepCollectionEquality().equals(
              other._lifestyleTips,
              _lifestyleTips,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scheduledTime,
    status,
    confirmedAt,
    notes,
    dosage,
    medicationName,
    imageUrl,
    withFood,
    withWater,
    specialInstructions,
    prescriptionId,
    doctorName,
    diagnosis,
    const DeepCollectionEquality().hash(_lifestyleTips),
  );

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationScheduleImplCopyWith<_$MedicationScheduleImpl> get copyWith =>
      __$$MedicationScheduleImplCopyWithImpl<_$MedicationScheduleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationScheduleImplToJson(this);
  }
}

abstract class _MedicationSchedule implements MedicationSchedule {
  const factory _MedicationSchedule({
    @JsonKey(fromJson: _intFromJson) required final int id,
    @JsonKey(name: 'scheduled_time') required final String scheduledTime,
    required final String status,
    @JsonKey(name: 'confirmed_at') final String? confirmedAt,
    final String? notes,
    required final String dosage,
    @JsonKey(name: 'medication_name') required final String medicationName,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required final bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required final bool withWater,
    @JsonKey(name: 'special_instructions') final String? specialInstructions,
    @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
    final int? prescriptionId,
    @JsonKey(name: 'doctor_name') final String? doctorName,
    final String? diagnosis,
    @JsonKey(name: 'lifestyle_tips')
    final List<Map<String, String>>? lifestyleTips,
  }) = _$MedicationScheduleImpl;

  factory _MedicationSchedule.fromJson(Map<String, dynamic> json) =
      _$MedicationScheduleImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  @JsonKey(name: 'scheduled_time')
  String get scheduledTime;
  @override
  String get status; // pending, taken, missed, skipped
  @override
  @JsonKey(name: 'confirmed_at')
  String? get confirmedAt;
  @override
  String? get notes;
  @override
  String get dosage;
  @override
  @JsonKey(name: 'medication_name')
  String get medicationName;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withFood;
  @override
  @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withWater;
  @override
  @JsonKey(name: 'special_instructions')
  String? get specialInstructions;
  @override
  @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
  int? get prescriptionId;
  @override
  @JsonKey(name: 'doctor_name')
  String? get doctorName;
  @override
  String? get diagnosis;
  @override
  @JsonKey(name: 'lifestyle_tips')
  List<Map<String, String>>? get lifestyleTips;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationScheduleImplCopyWith<_$MedicationScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
