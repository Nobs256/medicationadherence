// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationImpl _$$MedicationImplFromJson(Map<String, dynamic> json) =>
    _$MedicationImpl(
      id: _intFromJson(json['id']),
      hospitalId: _intFromDynamic(json['hospital_id']),
      name: json['name'] as String,
      genericName: json['generic_name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      imageUrl: json['image_url'] as String?,
      createdByName: json['created_by_name'] as String?,
    );

Map<String, dynamic> _$$MedicationImplToJson(_$MedicationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hospital_id': instance.hospitalId,
      'name': instance.name,
      'generic_name': instance.genericName,
      'description': instance.description,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'created_by_name': instance.createdByName,
    };
