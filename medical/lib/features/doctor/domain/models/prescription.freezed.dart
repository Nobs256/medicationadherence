// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  return _Prescription.fromJson(json);
}

/// @nodoc
mixin _$Prescription {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  String get diagnosis => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_name')
  String get doctorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_name')
  String? get patientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
  int? get medicationCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'advice_count', fromJson: _intFromDynamic)
  int? get adviceCount => throw _privateConstructorUsedError;
  List<PrescriptionMedication>? get medications =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'lifestyle_advice')
  List<LifestyleAdvice>? get lifestyleAdvice =>
      throw _privateConstructorUsedError;

  /// Serializes this Prescription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrescriptionCopyWith<Prescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrescriptionCopyWith<$Res> {
  factory $PrescriptionCopyWith(
    Prescription value,
    $Res Function(Prescription) then,
  ) = _$PrescriptionCopyWithImpl<$Res, Prescription>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    String diagnosis,
    String? notes,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) bool isActive,
    @JsonKey(name: 'doctor_name') String doctorName,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
    int? medicationCount,
    @JsonKey(name: 'advice_count', fromJson: _intFromDynamic) int? adviceCount,
    List<PrescriptionMedication>? medications,
    @JsonKey(name: 'lifestyle_advice') List<LifestyleAdvice>? lifestyleAdvice,
  });
}

/// @nodoc
class _$PrescriptionCopyWithImpl<$Res, $Val extends Prescription>
    implements $PrescriptionCopyWith<$Res> {
  _$PrescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diagnosis = null,
    Object? notes = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? doctorName = null,
    Object? patientName = freezed,
    Object? medicationCount = freezed,
    Object? adviceCount = freezed,
    Object? medications = freezed,
    Object? lifestyleAdvice = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            diagnosis:
                null == diagnosis
                    ? _value.diagnosis
                    : diagnosis // ignore: cast_nullable_to_non_nullable
                        as String,
            notes:
                freezed == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String?,
            startDate:
                null == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as String,
            endDate:
                freezed == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            doctorName:
                null == doctorName
                    ? _value.doctorName
                    : doctorName // ignore: cast_nullable_to_non_nullable
                        as String,
            patientName:
                freezed == patientName
                    ? _value.patientName
                    : patientName // ignore: cast_nullable_to_non_nullable
                        as String?,
            medicationCount:
                freezed == medicationCount
                    ? _value.medicationCount
                    : medicationCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            adviceCount:
                freezed == adviceCount
                    ? _value.adviceCount
                    : adviceCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            medications:
                freezed == medications
                    ? _value.medications
                    : medications // ignore: cast_nullable_to_non_nullable
                        as List<PrescriptionMedication>?,
            lifestyleAdvice:
                freezed == lifestyleAdvice
                    ? _value.lifestyleAdvice
                    : lifestyleAdvice // ignore: cast_nullable_to_non_nullable
                        as List<LifestyleAdvice>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrescriptionImplCopyWith<$Res>
    implements $PrescriptionCopyWith<$Res> {
  factory _$$PrescriptionImplCopyWith(
    _$PrescriptionImpl value,
    $Res Function(_$PrescriptionImpl) then,
  ) = __$$PrescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    String diagnosis,
    String? notes,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) bool isActive,
    @JsonKey(name: 'doctor_name') String doctorName,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
    int? medicationCount,
    @JsonKey(name: 'advice_count', fromJson: _intFromDynamic) int? adviceCount,
    List<PrescriptionMedication>? medications,
    @JsonKey(name: 'lifestyle_advice') List<LifestyleAdvice>? lifestyleAdvice,
  });
}

/// @nodoc
class __$$PrescriptionImplCopyWithImpl<$Res>
    extends _$PrescriptionCopyWithImpl<$Res, _$PrescriptionImpl>
    implements _$$PrescriptionImplCopyWith<$Res> {
  __$$PrescriptionImplCopyWithImpl(
    _$PrescriptionImpl _value,
    $Res Function(_$PrescriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diagnosis = null,
    Object? notes = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? doctorName = null,
    Object? patientName = freezed,
    Object? medicationCount = freezed,
    Object? adviceCount = freezed,
    Object? medications = freezed,
    Object? lifestyleAdvice = freezed,
  }) {
    return _then(
      _$PrescriptionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        diagnosis:
            null == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                    as String,
        notes:
            freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String?,
        startDate:
            null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as String,
        endDate:
            freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        doctorName:
            null == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                    as String,
        patientName:
            freezed == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                    as String?,
        medicationCount:
            freezed == medicationCount
                ? _value.medicationCount
                : medicationCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        adviceCount:
            freezed == adviceCount
                ? _value.adviceCount
                : adviceCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        medications:
            freezed == medications
                ? _value._medications
                : medications // ignore: cast_nullable_to_non_nullable
                    as List<PrescriptionMedication>?,
        lifestyleAdvice:
            freezed == lifestyleAdvice
                ? _value._lifestyleAdvice
                : lifestyleAdvice // ignore: cast_nullable_to_non_nullable
                    as List<LifestyleAdvice>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrescriptionImpl implements _Prescription {
  const _$PrescriptionImpl({
    @JsonKey(fromJson: _intFromJson) required this.id,
    required this.diagnosis,
    this.notes,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') this.endDate,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) required this.isActive,
    @JsonKey(name: 'doctor_name') required this.doctorName,
    @JsonKey(name: 'patient_name') this.patientName,
    @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
    this.medicationCount,
    @JsonKey(name: 'advice_count', fromJson: _intFromDynamic) this.adviceCount,
    final List<PrescriptionMedication>? medications,
    @JsonKey(name: 'lifestyle_advice')
    final List<LifestyleAdvice>? lifestyleAdvice,
  }) : _medications = medications,
       _lifestyleAdvice = lifestyleAdvice;

  factory _$PrescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrescriptionImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  final String diagnosis;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'start_date')
  final String startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  final bool isActive;
  @override
  @JsonKey(name: 'doctor_name')
  final String doctorName;
  @override
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @override
  @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
  final int? medicationCount;
  @override
  @JsonKey(name: 'advice_count', fromJson: _intFromDynamic)
  final int? adviceCount;
  final List<PrescriptionMedication>? _medications;
  @override
  List<PrescriptionMedication>? get medications {
    final value = _medications;
    if (value == null) return null;
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LifestyleAdvice>? _lifestyleAdvice;
  @override
  @JsonKey(name: 'lifestyle_advice')
  List<LifestyleAdvice>? get lifestyleAdvice {
    final value = _lifestyleAdvice;
    if (value == null) return null;
    if (_lifestyleAdvice is EqualUnmodifiableListView) return _lifestyleAdvice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Prescription(id: $id, diagnosis: $diagnosis, notes: $notes, startDate: $startDate, endDate: $endDate, isActive: $isActive, doctorName: $doctorName, patientName: $patientName, medicationCount: $medicationCount, adviceCount: $adviceCount, medications: $medications, lifestyleAdvice: $lifestyleAdvice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrescriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.medicationCount, medicationCount) ||
                other.medicationCount == medicationCount) &&
            (identical(other.adviceCount, adviceCount) ||
                other.adviceCount == adviceCount) &&
            const DeepCollectionEquality().equals(
              other._medications,
              _medications,
            ) &&
            const DeepCollectionEquality().equals(
              other._lifestyleAdvice,
              _lifestyleAdvice,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    diagnosis,
    notes,
    startDate,
    endDate,
    isActive,
    doctorName,
    patientName,
    medicationCount,
    adviceCount,
    const DeepCollectionEquality().hash(_medications),
    const DeepCollectionEquality().hash(_lifestyleAdvice),
  );

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrescriptionImplCopyWith<_$PrescriptionImpl> get copyWith =>
      __$$PrescriptionImplCopyWithImpl<_$PrescriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrescriptionImplToJson(this);
  }
}

abstract class _Prescription implements Prescription {
  const factory _Prescription({
    @JsonKey(fromJson: _intFromJson) required final int id,
    required final String diagnosis,
    final String? notes,
    @JsonKey(name: 'start_date') required final String startDate,
    @JsonKey(name: 'end_date') final String? endDate,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt)
    required final bool isActive,
    @JsonKey(name: 'doctor_name') required final String doctorName,
    @JsonKey(name: 'patient_name') final String? patientName,
    @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
    final int? medicationCount,
    @JsonKey(name: 'advice_count', fromJson: _intFromDynamic)
    final int? adviceCount,
    final List<PrescriptionMedication>? medications,
    @JsonKey(name: 'lifestyle_advice')
    final List<LifestyleAdvice>? lifestyleAdvice,
  }) = _$PrescriptionImpl;

  factory _Prescription.fromJson(Map<String, dynamic> json) =
      _$PrescriptionImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  String get diagnosis;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'start_date')
  String get startDate;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  bool get isActive;
  @override
  @JsonKey(name: 'doctor_name')
  String get doctorName;
  @override
  @JsonKey(name: 'patient_name')
  String? get patientName;
  @override
  @JsonKey(name: 'medication_count', fromJson: _intFromDynamic)
  int? get medicationCount;
  @override
  @JsonKey(name: 'advice_count', fromJson: _intFromDynamic)
  int? get adviceCount;
  @override
  List<PrescriptionMedication>? get medications;
  @override
  @JsonKey(name: 'lifestyle_advice')
  List<LifestyleAdvice>? get lifestyleAdvice;

  /// Create a copy of Prescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrescriptionImplCopyWith<_$PrescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
