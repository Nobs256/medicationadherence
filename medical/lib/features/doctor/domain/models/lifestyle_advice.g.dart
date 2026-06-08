// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifestyle_advice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LifestyleAdviceImpl _$$LifestyleAdviceImplFromJson(
  Map<String, dynamic> json,
) => _$LifestyleAdviceImpl(
  id: _intFromJson(json['id']),
  prescriptionId: _intFromJson(json['prescription_id']),
  adviceType: json['advice_type'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  frequency: json['frequency'] as String?,
  durationMinutes: _intFromDynamic(json['duration_minutes']),
);

Map<String, dynamic> _$$LifestyleAdviceImplToJson(
  _$LifestyleAdviceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'prescription_id': instance.prescriptionId,
  'advice_type': instance.adviceType,
  'title': instance.title,
  'description': instance.description,
  'frequency': instance.frequency,
  'duration_minutes': instance.durationMinutes,
};
