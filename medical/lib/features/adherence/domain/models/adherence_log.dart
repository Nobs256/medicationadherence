import 'package:freezed_annotation/freezed_annotation.dart';

part 'adherence_log.freezed.dart';
part 'adherence_log.g.dart';

@freezed
class AdherenceLog with _$AdherenceLog {
  const factory AdherenceLog({
    @JsonKey(name: 'log_date') required String logDate,
    @JsonKey(name: 'total_scheduled', fromJson: _intFromJson)
    required int totalScheduled,
    @JsonKey(name: 'total_taken', fromJson: _intFromJson)
    required int totalTaken,
    @JsonKey(name: 'total_missed', fromJson: _intFromJson)
    required int totalMissed,
    @JsonKey(name: 'total_skipped', fromJson: _intFromJson)
    required int totalSkipped,
    @JsonKey(name: 'adherence_percentage', fromJson: _doubleFromDynamic)
    required double adherencePercentage,
  }) = _AdherenceLog;

  factory AdherenceLog.fromJson(Map<String, dynamic> json) =>
      _$AdherenceLogFromJson(json);
}

double _doubleFromDynamic(dynamic val) {
  if (val == null) return 0.0;
  if (val is num) return val.toDouble();
  return double.tryParse(val.toString()) ?? 0.0;
}

int _intFromJson(dynamic val) =>
    val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

int? _intFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  return int.tryParse(val.toString());
}
