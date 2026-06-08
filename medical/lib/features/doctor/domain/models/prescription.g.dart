// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrescriptionImpl _$$PrescriptionImplFromJson(Map<String, dynamic> json) =>
    _$PrescriptionImpl(
      id: _intFromJson(json['id']),
      diagnosis: json['diagnosis'] as String,
      notes: json['notes'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      isActive: _boolFromInt(json['is_active']),
      doctorName: json['doctor_name'] as String,
      patientName: json['patient_name'] as String?,
      medicationCount: _intFromDynamic(json['medication_count']),
      adviceCount: _intFromDynamic(json['advice_count']),
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PrescriptionMedication.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      lifestyleAdvice:
          (json['lifestyle_advice'] as List<dynamic>?)
              ?.map((e) => LifestyleAdvice.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PrescriptionImplToJson(_$PrescriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diagnosis': instance.diagnosis,
      'notes': instance.notes,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'is_active': instance.isActive,
      'doctor_name': instance.doctorName,
      'patient_name': instance.patientName,
      'medication_count': instance.medicationCount,
      'advice_count': instance.adviceCount,
      'medications': instance.medications,
      'lifestyle_advice': instance.lifestyleAdvice,
    };
