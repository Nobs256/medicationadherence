// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: _intFromAny(json['id']),
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      roleName: json['role_name'] as String,
      hospitalId: _intFromAnyNullable(json['hospital_id']),
      hospitalName: json['hospital_name'] as String?,
      hospitalLogo: json['hospital_logo'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      emergencyContact: json['emergency_contact'] as String?,
      diagnosis: json['diagnosis'] as String?,
      isActive: _boolFromInt(json['is_active']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'role_name': instance.roleName,
      'hospital_id': instance.hospitalId,
      'hospital_name': instance.hospitalName,
      'hospital_logo': instance.hospitalLogo,
      'avatar_url': instance.avatarUrl,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'emergency_contact': instance.emergencyContact,
      'diagnosis': instance.diagnosis,
      'is_active': _boolToInt(instance.isActive),
    };
