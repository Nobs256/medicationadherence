// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifestyle_advice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LifestyleAdviceImpl _$$LifestyleAdviceImplFromJson(
  Map<String, dynamic> json,
) => _$LifestyleAdviceImpl(
  id: (json['id'] as num).toInt(),
  prescriptionId: (json['prescription_id'] as num).toInt(),
  adviceType: json['advice_type'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  frequency: json['frequency'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
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
