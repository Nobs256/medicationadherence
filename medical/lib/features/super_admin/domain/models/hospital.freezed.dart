// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hospital.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Hospital _$HospitalFromJson(Map<String, dynamic> json) {
  return _Hospital.fromJson(json);
}

/// @nodoc
mixin _$Hospital {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic)
  int? get doctorCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
  int? get patientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
  double? get avgAdherence => throw _privateConstructorUsedError;

  /// Serializes this Hospital to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HospitalCopyWith<Hospital> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HospitalCopyWith<$Res> {
  factory $HospitalCopyWith(Hospital value, $Res Function(Hospital) then) =
      _$HospitalCopyWithImpl<$Res, Hospital>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    String name,
    String? address,
    String? phone,
    String? email,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) bool isActive,
    @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic) int? doctorCount,
    @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
    int? patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
    double? avgAdherence,
  });
}

/// @nodoc
class _$HospitalCopyWithImpl<$Res, $Val extends Hospital>
    implements $HospitalCopyWith<$Res> {
  _$HospitalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? logoUrl = freezed,
    Object? isActive = null,
    Object? doctorCount = freezed,
    Object? patientCount = freezed,
    Object? avgAdherence = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            logoUrl:
                freezed == logoUrl
                    ? _value.logoUrl
                    : logoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            doctorCount:
                freezed == doctorCount
                    ? _value.doctorCount
                    : doctorCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            patientCount:
                freezed == patientCount
                    ? _value.patientCount
                    : patientCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            avgAdherence:
                freezed == avgAdherence
                    ? _value.avgAdherence
                    : avgAdherence // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HospitalImplCopyWith<$Res>
    implements $HospitalCopyWith<$Res> {
  factory _$$HospitalImplCopyWith(
    _$HospitalImpl value,
    $Res Function(_$HospitalImpl) then,
  ) = __$$HospitalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    String name,
    String? address,
    String? phone,
    String? email,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) bool isActive,
    @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic) int? doctorCount,
    @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
    int? patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
    double? avgAdherence,
  });
}

/// @nodoc
class __$$HospitalImplCopyWithImpl<$Res>
    extends _$HospitalCopyWithImpl<$Res, _$HospitalImpl>
    implements _$$HospitalImplCopyWith<$Res> {
  __$$HospitalImplCopyWithImpl(
    _$HospitalImpl _value,
    $Res Function(_$HospitalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? logoUrl = freezed,
    Object? isActive = null,
    Object? doctorCount = freezed,
    Object? patientCount = freezed,
    Object? avgAdherence = freezed,
  }) {
    return _then(
      _$HospitalImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        logoUrl:
            freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        doctorCount:
            freezed == doctorCount
                ? _value.doctorCount
                : doctorCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        patientCount:
            freezed == patientCount
                ? _value.patientCount
                : patientCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        avgAdherence:
            freezed == avgAdherence
                ? _value.avgAdherence
                : avgAdherence // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HospitalImpl implements _Hospital {
  const _$HospitalImpl({
    @JsonKey(fromJson: _intFromJson) required this.id,
    required this.name,
    this.address,
    this.phone,
    this.email,
    @JsonKey(name: 'logo_url') this.logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) required this.isActive,
    @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic) this.doctorCount,
    @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
    this.patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
    this.avgAdherence,
  });

  factory _$HospitalImpl.fromJson(Map<String, dynamic> json) =>
      _$$HospitalImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  final String name;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  final bool isActive;
  @override
  @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic)
  final int? doctorCount;
  @override
  @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
  final int? patientCount;
  @override
  @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
  final double? avgAdherence;

  @override
  String toString() {
    return 'Hospital(id: $id, name: $name, address: $address, phone: $phone, email: $email, logoUrl: $logoUrl, isActive: $isActive, doctorCount: $doctorCount, patientCount: $patientCount, avgAdherence: $avgAdherence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HospitalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.doctorCount, doctorCount) ||
                other.doctorCount == doctorCount) &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount) &&
            (identical(other.avgAdherence, avgAdherence) ||
                other.avgAdherence == avgAdherence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    phone,
    email,
    logoUrl,
    isActive,
    doctorCount,
    patientCount,
    avgAdherence,
  );

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HospitalImplCopyWith<_$HospitalImpl> get copyWith =>
      __$$HospitalImplCopyWithImpl<_$HospitalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HospitalImplToJson(this);
  }
}

abstract class _Hospital implements Hospital {
  const factory _Hospital({
    @JsonKey(fromJson: _intFromJson) required final int id,
    required final String name,
    final String? address,
    final String? phone,
    final String? email,
    @JsonKey(name: 'logo_url') final String? logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt)
    required final bool isActive,
    @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic)
    final int? doctorCount,
    @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
    final int? patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
    final double? avgAdherence,
  }) = _$HospitalImpl;

  factory _Hospital.fromJson(Map<String, dynamic> json) =
      _$HospitalImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  String get name;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt)
  bool get isActive;
  @override
  @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic)
  int? get doctorCount;
  @override
  @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
  int? get patientCount;
  @override
  @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
  double? get avgAdherence;

  /// Create a copy of Hospital
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HospitalImplCopyWith<_$HospitalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
