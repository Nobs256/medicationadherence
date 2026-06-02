// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationScheduleImpl _$$MedicationScheduleImplFromJson(
  Map<String, dynamic> json,
) => _$MedicationScheduleImpl(
  id: (json['id'] as num).toInt(),
  scheduledTime: json['scheduled_time'] as String,
  status: json['status'] as String,
  confirmedAt: json['confirmed_at'] as String?,
  notes: json['notes'] as String?,
  dosage: json['dosage'] as String,
  medicationName: json['medication_name'] as String,
  imageUrl: json['image_url'] as String?,
  withFood: _boolFromInt(json['with_food']),
  withWater: _boolFromInt(json['with_water']),
  specialInstructions: json['special_instructions'] as String?,
  prescriptionId: json['prescription_id'] as String?,
  doctorName: json['doctor_name'] as String?,
  diagnosis: json['diagnosis'] as String?,
  lifestyleTips:
      (json['lifestyle_tips'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
);

Map<String, dynamic> _$$MedicationScheduleImplToJson(
  _$MedicationScheduleImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'scheduled_time': instance.scheduledTime,
  'status': instance.status,
  'confirmed_at': instance.confirmedAt,
  'notes': instance.notes,
  'dosage': instance.dosage,
  'medication_name': instance.medicationName,
  'image_url': instance.imageUrl,
  'with_food': _boolToInt(instance.withFood),
  'with_water': _boolToInt(instance.withWater),
  'special_instructions': instance.specialInstructions,
  'prescription_id': instance.prescriptionId,
  'doctor_name': instance.doctorName,
  'diagnosis': instance.diagnosis,
  'lifestyle_tips': instance.lifestyleTips,
};
