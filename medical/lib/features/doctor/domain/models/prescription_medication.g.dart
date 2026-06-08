// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrescriptionMedicationImpl _$$PrescriptionMedicationImplFromJson(
  Map<String, dynamic> json,
) => _$PrescriptionMedicationImpl(
  id: _intFromJson(json['id']),
  medicationId: _intFromJson(json['medication_id']),
  medicationName: json['medication_name'] as String,
  genericName: json['generic_name'] as String?,
  category: json['category'] as String?,
  medicationDescription: json['medication_description'] as String?,
  imageUrl: json['image_url'] as String?,
  dosage: json['dosage'] as String,
  frequency: json['frequency'] as String,
  timesOfDay:
      (json['times_of_day'] as List<dynamic>).map((e) => e as String).toList(),
  withFood: _boolFromInt(json['with_food']),
  withWater: _boolFromInt(json['with_water']),
  specialInstructions: json['special_instructions'] as String?,
  durationDays: _intFromDynamic(json['duration_days']),
);

Map<String, dynamic> _$$PrescriptionMedicationImplToJson(
  _$PrescriptionMedicationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'medication_id': instance.medicationId,
  'medication_name': instance.medicationName,
  'generic_name': instance.genericName,
  'category': instance.category,
  'medication_description': instance.medicationDescription,
  'image_url': instance.imageUrl,
  'dosage': instance.dosage,
  'frequency': instance.frequency,
  'times_of_day': instance.timesOfDay,
  'with_food': _boolToInt(instance.withFood),
  'with_water': _boolToInt(instance.withWater),
  'special_instructions': instance.specialInstructions,
  'duration_days': instance.durationDays,
};
