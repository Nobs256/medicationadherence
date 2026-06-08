// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  @JsonKey(fromJson: _intFromAny)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_name')
  String get roleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
  int? get hospitalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_name')
  String? get hospitalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_logo')
  String? get hospitalLogo => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get diagnosis => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromAny) int id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String? phone,
    @JsonKey(name: 'role_name') String roleName,
    @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
    int? hospitalId,
    @JsonKey(name: 'hospital_name') String? hospitalName,
    @JsonKey(name: 'hospital_logo') String? hospitalLogo,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? gender,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    String? diagnosis,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? roleName = null,
    Object? hospitalId = freezed,
    Object? hospitalName = freezed,
    Object? hospitalLogo = freezed,
    Object? avatarUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? emergencyContact = freezed,
    Object? diagnosis = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            fullName:
                null == fullName
                    ? _value.fullName
                    : fullName // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            roleName:
                null == roleName
                    ? _value.roleName
                    : roleName // ignore: cast_nullable_to_non_nullable
                        as String,
            hospitalId:
                freezed == hospitalId
                    ? _value.hospitalId
                    : hospitalId // ignore: cast_nullable_to_non_nullable
                        as int?,
            hospitalName:
                freezed == hospitalName
                    ? _value.hospitalName
                    : hospitalName // ignore: cast_nullable_to_non_nullable
                        as String?,
            hospitalLogo:
                freezed == hospitalLogo
                    ? _value.hospitalLogo
                    : hospitalLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatarUrl:
                freezed == avatarUrl
                    ? _value.avatarUrl
                    : avatarUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            dateOfBirth:
                freezed == dateOfBirth
                    ? _value.dateOfBirth
                    : dateOfBirth // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            emergencyContact:
                freezed == emergencyContact
                    ? _value.emergencyContact
                    : emergencyContact // ignore: cast_nullable_to_non_nullable
                        as String?,
            diagnosis:
                freezed == diagnosis
                    ? _value.diagnosis
                    : diagnosis // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromAny) int id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String? phone,
    @JsonKey(name: 'role_name') String roleName,
    @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
    int? hospitalId,
    @JsonKey(name: 'hospital_name') String? hospitalName,
    @JsonKey(name: 'hospital_logo') String? hospitalLogo,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? gender,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    String? diagnosis,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    bool isActive,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? roleName = null,
    Object? hospitalId = freezed,
    Object? hospitalName = freezed,
    Object? hospitalLogo = freezed,
    Object? avatarUrl = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? emergencyContact = freezed,
    Object? diagnosis = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        fullName:
            null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        roleName:
            null == roleName
                ? _value.roleName
                : roleName // ignore: cast_nullable_to_non_nullable
                    as String,
        hospitalId:
            freezed == hospitalId
                ? _value.hospitalId
                : hospitalId // ignore: cast_nullable_to_non_nullable
                    as int?,
        hospitalName:
            freezed == hospitalName
                ? _value.hospitalName
                : hospitalName // ignore: cast_nullable_to_non_nullable
                    as String?,
        hospitalLogo:
            freezed == hospitalLogo
                ? _value.hospitalLogo
                : hospitalLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatarUrl:
            freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateOfBirth:
            freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        emergencyContact:
            freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                    as String?,
        diagnosis:
            freezed == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    @JsonKey(fromJson: _intFromAny) required this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    required this.email,
    this.phone,
    @JsonKey(name: 'role_name') required this.roleName,
    @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
    this.hospitalId,
    @JsonKey(name: 'hospital_name') this.hospitalName,
    @JsonKey(name: 'hospital_logo') this.hospitalLogo,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'date_of_birth') this.dateOfBirth,
    this.gender,
    @JsonKey(name: 'emergency_contact') this.emergencyContact,
    this.diagnosis,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    required this.isActive,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromAny)
  final int id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String email;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'role_name')
  final String roleName;
  @override
  @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
  final int? hospitalId;
  @override
  @JsonKey(name: 'hospital_name')
  final String? hospitalName;
  @override
  @JsonKey(name: 'hospital_logo')
  final String? hospitalLogo;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @override
  final String? diagnosis;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isActive;

  @override
  String toString() {
    return 'UserProfile(id: $id, fullName: $fullName, email: $email, phone: $phone, roleName: $roleName, hospitalId: $hospitalId, hospitalName: $hospitalName, hospitalLogo: $hospitalLogo, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, gender: $gender, emergencyContact: $emergencyContact, diagnosis: $diagnosis, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.roleName, roleName) ||
                other.roleName == roleName) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId) &&
            (identical(other.hospitalName, hospitalName) ||
                other.hospitalName == hospitalName) &&
            (identical(other.hospitalLogo, hospitalLogo) ||
                other.hospitalLogo == hospitalLogo) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    email,
    phone,
    roleName,
    hospitalId,
    hospitalName,
    hospitalLogo,
    avatarUrl,
    dateOfBirth,
    gender,
    emergencyContact,
    diagnosis,
    isActive,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    @JsonKey(fromJson: _intFromAny) required final int id,
    @JsonKey(name: 'full_name') required final String fullName,
    required final String email,
    final String? phone,
    @JsonKey(name: 'role_name') required final String roleName,
    @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
    final int? hospitalId,
    @JsonKey(name: 'hospital_name') final String? hospitalName,
    @JsonKey(name: 'hospital_logo') final String? hospitalLogo,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'date_of_birth') final String? dateOfBirth,
    final String? gender,
    @JsonKey(name: 'emergency_contact') final String? emergencyContact,
    final String? diagnosis,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    required final bool isActive,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromAny)
  int get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'role_name')
  String get roleName;
  @override
  @JsonKey(name: 'hospital_id', fromJson: _intFromAnyNullable)
  int? get hospitalId;
  @override
  @JsonKey(name: 'hospital_name')
  String? get hospitalName;
  @override
  @JsonKey(name: 'hospital_logo')
  String? get hospitalLogo;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact;
  @override
  String? get diagnosis;
  @override
  @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
  bool get isActive;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
