// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HospitalImpl _$$HospitalImplFromJson(Map<String, dynamic> json) =>
    _$HospitalImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      logoUrl: json['logo_url'] as String?,
      isActive: _boolFromInt(json['is_active']),
      doctorCount: (json['doctor_count'] as num?)?.toInt(),
      patientCount: (json['patient_count'] as num?)?.toInt(),
      avgAdherence: _doubleFromDynamic(json['avg_adherence']),
    );

Map<String, dynamic> _$$HospitalImplToJson(_$HospitalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'logo_url': instance.logoUrl,
      'is_active': instance.isActive,
      'doctor_count': instance.doctorCount,
      'patient_count': instance.patientCount,
      'avg_adherence': instance.avgAdherence,
    };
