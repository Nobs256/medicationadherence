// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalAdmin _$HospitalAdminFromJson(Map<String, dynamic> json) =>
    HospitalAdmin(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$HospitalAdminToJson(HospitalAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'is_active': instance.isActive,
    };
