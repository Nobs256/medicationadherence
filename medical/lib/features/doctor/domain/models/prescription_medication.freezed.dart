// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescription_medication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PrescriptionMedication _$PrescriptionMedicationFromJson(
  Map<String, dynamic> json,
) {
  return _PrescriptionMedication.fromJson(json);
}

/// @nodoc
mixin _$PrescriptionMedication {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_id')
  int get medicationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_name')
  String get medicationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'generic_name')
  String? get genericName => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_description')
  String? get medicationDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  @JsonKey(name: 'times_of_day')
  List<String> get timesOfDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withFood => throw _privateConstructorUsedError;
  @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get withWater => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_instructions')
  String? get specialInstructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_days')
  int? get durationDays => throw _privateConstructorUsedError;

  /// Serializes this PrescriptionMedication to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrescriptionMedication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrescriptionMedicationCopyWith<PrescriptionMedication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrescriptionMedicationCopyWith<$Res> {
  factory $PrescriptionMedicationCopyWith(
    PrescriptionMedication value,
    $Res Function(PrescriptionMedication) then,
  ) = _$PrescriptionMedicationCopyWithImpl<$Res, PrescriptionMedication>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'medication_id') int medicationId,
    @JsonKey(name: 'medication_name') String medicationName,
    @JsonKey(name: 'generic_name') String? genericName,
    String? category,
    @JsonKey(name: 'medication_description') String? medicationDescription,
    @JsonKey(name: 'image_url') String? imageUrl,
    String dosage,
    String frequency,
    @JsonKey(name: 'times_of_day') List<String> timesOfDay,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'duration_days') int? durationDays,
  });
}

/// @nodoc
class _$PrescriptionMedicationCopyWithImpl<
  $Res,
  $Val extends PrescriptionMedication
>
    implements $PrescriptionMedicationCopyWith<$Res> {
  _$PrescriptionMedicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrescriptionMedication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? medicationId = null,
    Object? medicationName = null,
    Object? genericName = freezed,
    Object? category = freezed,
    Object? medicationDescription = freezed,
    Object? imageUrl = freezed,
    Object? dosage = null,
    Object? frequency = null,
    Object? timesOfDay = null,
    Object? withFood = null,
    Object? withWater = null,
    Object? specialInstructions = freezed,
    Object? durationDays = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            medicationId:
                null == medicationId
                    ? _value.medicationId
                    : medicationId // ignore: cast_nullable_to_non_nullable
                        as int,
            medicationName:
                null == medicationName
                    ? _value.medicationName
                    : medicationName // ignore: cast_nullable_to_non_nullable
                        as String,
            genericName:
                freezed == genericName
                    ? _value.genericName
                    : genericName // ignore: cast_nullable_to_non_nullable
                        as String?,
            category:
                freezed == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String?,
            medicationDescription:
                freezed == medicationDescription
                    ? _value.medicationDescription
                    : medicationDescription // ignore: cast_nullable_to_non_nullable
                        as String?,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            dosage:
                null == dosage
                    ? _value.dosage
                    : dosage // ignore: cast_nullable_to_non_nullable
                        as String,
            frequency:
                null == frequency
                    ? _value.frequency
                    : frequency // ignore: cast_nullable_to_non_nullable
                        as String,
            timesOfDay:
                null == timesOfDay
                    ? _value.timesOfDay
                    : timesOfDay // ignore: cast_nullable_to_non_nullable
                        as List<String>,
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
            durationDays:
                freezed == durationDays
                    ? _value.durationDays
                    : durationDays // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrescriptionMedicationImplCopyWith<$Res>
    implements $PrescriptionMedicationCopyWith<$Res> {
  factory _$$PrescriptionMedicationImplCopyWith(
    _$PrescriptionMedicationImpl value,
    $Res Function(_$PrescriptionMedicationImpl) then,
  ) = __$$PrescriptionMedicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'medication_id') int medicationId,
    @JsonKey(name: 'medication_name') String medicationName,
    @JsonKey(name: 'generic_name') String? genericName,
    String? category,
    @JsonKey(name: 'medication_description') String? medicationDescription,
    @JsonKey(name: 'image_url') String? imageUrl,
    String dosage,
    String frequency,
    @JsonKey(name: 'times_of_day') List<String> timesOfDay,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'duration_days') int? durationDays,
  });
}

/// @nodoc
class __$$PrescriptionMedicationImplCopyWithImpl<$Res>
    extends
        _$PrescriptionMedicationCopyWithImpl<$Res, _$PrescriptionMedicationImpl>
    implements _$$PrescriptionMedicationImplCopyWith<$Res> {
  __$$PrescriptionMedicationImplCopyWithImpl(
    _$PrescriptionMedicationImpl _value,
    $Res Function(_$PrescriptionMedicationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrescriptionMedication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? medicationId = null,
    Object? medicationName = null,
    Object? genericName = freezed,
    Object? category = freezed,
    Object? medicationDescription = freezed,
    Object? imageUrl = freezed,
    Object? dosage = null,
    Object? frequency = null,
    Object? timesOfDay = null,
    Object? withFood = null,
    Object? withWater = null,
    Object? specialInstructions = freezed,
    Object? durationDays = freezed,
  }) {
    return _then(
      _$PrescriptionMedicationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        medicationId:
            null == medicationId
                ? _value.medicationId
                : medicationId // ignore: cast_nullable_to_non_nullable
                    as int,
        medicationName:
            null == medicationName
                ? _value.medicationName
                : medicationName // ignore: cast_nullable_to_non_nullable
                    as String,
        genericName:
            freezed == genericName
                ? _value.genericName
                : genericName // ignore: cast_nullable_to_non_nullable
                    as String?,
        category:
            freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String?,
        medicationDescription:
            freezed == medicationDescription
                ? _value.medicationDescription
                : medicationDescription // ignore: cast_nullable_to_non_nullable
                    as String?,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        dosage:
            null == dosage
                ? _value.dosage
                : dosage // ignore: cast_nullable_to_non_nullable
                    as String,
        frequency:
            null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                    as String,
        timesOfDay:
            null == timesOfDay
                ? _value._timesOfDay
                : timesOfDay // ignore: cast_nullable_to_non_nullable
                    as List<String>,
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
        durationDays:
            freezed == durationDays
                ? _value.durationDays
                : durationDays // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrescriptionMedicationImpl implements _PrescriptionMedication {
  const _$PrescriptionMedicationImpl({
    required this.id,
    @JsonKey(name: 'medication_id') required this.medicationId,
    @JsonKey(name: 'medication_name') required this.medicationName,
    @JsonKey(name: 'generic_name') this.genericName,
    this.category,
    @JsonKey(name: 'medication_description') this.medicationDescription,
    @JsonKey(name: 'image_url') this.imageUrl,
    required this.dosage,
    required this.frequency,
    @JsonKey(name: 'times_of_day') required final List<String> timesOfDay,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required this.withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required this.withWater,
    @JsonKey(name: 'special_instructions') this.specialInstructions,
    @JsonKey(name: 'duration_days') this.durationDays,
  }) : _timesOfDay = timesOfDay;

  factory _$PrescriptionMedicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrescriptionMedicationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'medication_id')
  final int medicationId;
  @override
  @JsonKey(name: 'medication_name')
  final String medicationName;
  @override
  @JsonKey(name: 'generic_name')
  final String? genericName;
  @override
  final String? category;
  @override
  @JsonKey(name: 'medication_description')
  final String? medicationDescription;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String dosage;
  @override
  final String frequency;
  final List<String> _timesOfDay;
  @override
  @JsonKey(name: 'times_of_day')
  List<String> get timesOfDay {
    if (_timesOfDay is EqualUnmodifiableListView) return _timesOfDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timesOfDay);
  }

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
  @JsonKey(name: 'duration_days')
  final int? durationDays;

  @override
  String toString() {
    return 'PrescriptionMedication(id: $id, medicationId: $medicationId, medicationName: $medicationName, genericName: $genericName, category: $category, medicationDescription: $medicationDescription, imageUrl: $imageUrl, dosage: $dosage, frequency: $frequency, timesOfDay: $timesOfDay, withFood: $withFood, withWater: $withWater, specialInstructions: $specialInstructions, durationDays: $durationDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrescriptionMedicationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.medicationId, medicationId) ||
                other.medicationId == medicationId) &&
            (identical(other.medicationName, medicationName) ||
                other.medicationName == medicationName) &&
            (identical(other.genericName, genericName) ||
                other.genericName == genericName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.medicationDescription, medicationDescription) ||
                other.medicationDescription == medicationDescription) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(
              other._timesOfDay,
              _timesOfDay,
            ) &&
            (identical(other.withFood, withFood) ||
                other.withFood == withFood) &&
            (identical(other.withWater, withWater) ||
                other.withWater == withWater) &&
            (identical(other.specialInstructions, specialInstructions) ||
                other.specialInstructions == specialInstructions) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    medicationId,
    medicationName,
    genericName,
    category,
    medicationDescription,
    imageUrl,
    dosage,
    frequency,
    const DeepCollectionEquality().hash(_timesOfDay),
    withFood,
    withWater,
    specialInstructions,
    durationDays,
  );

  /// Create a copy of PrescriptionMedication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrescriptionMedicationImplCopyWith<_$PrescriptionMedicationImpl>
  get copyWith =>
      __$$PrescriptionMedicationImplCopyWithImpl<_$PrescriptionMedicationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrescriptionMedicationImplToJson(this);
  }
}

abstract class _PrescriptionMedication implements PrescriptionMedication {
  const factory _PrescriptionMedication({
    required final int id,
    @JsonKey(name: 'medication_id') required final int medicationId,
    @JsonKey(name: 'medication_name') required final String medicationName,
    @JsonKey(name: 'generic_name') final String? genericName,
    final String? category,
    @JsonKey(name: 'medication_description')
    final String? medicationDescription,
    @JsonKey(name: 'image_url') final String? imageUrl,
    required final String dosage,
    required final String frequency,
    @JsonKey(name: 'times_of_day') required final List<String> timesOfDay,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required final bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required final bool withWater,
    @JsonKey(name: 'special_instructions') final String? specialInstructions,
    @JsonKey(name: 'duration_days') final int? durationDays,
  }) = _$PrescriptionMedicationImpl;

  factory _PrescriptionMedication.fromJson(Map<String, dynamic> json) =
      _$PrescriptionMedicationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'medication_id')
  int get medicationId;
  @override
  @JsonKey(name: 'medication_name')
  String get medicationName;
  @override
  @JsonKey(name: 'generic_name')
  String? get genericName;
  @override
  String? get category;
  @override
  @JsonKey(name: 'medication_description')
  String? get medicationDescription;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  String get dosage;
  @override
  String get frequency;
  @override
  @JsonKey(name: 'times_of_day')
  List<String> get timesOfDay;
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
  @JsonKey(name: 'duration_days')
  int? get durationDays;

  /// Create a copy of PrescriptionMedication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrescriptionMedicationImplCopyWith<_$PrescriptionMedicationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
