// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adherence_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdherenceLogImpl _$$AdherenceLogImplFromJson(Map<String, dynamic> json) =>
    _$AdherenceLogImpl(
      logDate: json['log_date'] as String,
      totalScheduled: (json['total_scheduled'] as num).toInt(),
      totalTaken: (json['total_taken'] as num).toInt(),
      totalMissed: (json['total_missed'] as num).toInt(),
      totalSkipped: (json['total_skipped'] as num).toInt(),
      adherencePercentage: _doubleFromDynamic(json['adherence_percentage']),
    );

Map<String, dynamic> _$$AdherenceLogImplToJson(_$AdherenceLogImpl instance) =>
    <String, dynamic>{
      'log_date': instance.logDate,
      'total_scheduled': instance.totalScheduled,
      'total_taken': instance.totalTaken,
      'total_missed': instance.totalMissed,
      'total_skipped': instance.totalSkipped,
      'adherence_percentage': instance.adherencePercentage,
    };
