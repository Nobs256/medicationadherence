import 'package:freezed_annotation/freezed_annotation.dart';

part 'adherence_log.freezed.dart';
part 'adherence_log.g.dart';

@freezed
class AdherenceLog with _$AdherenceLog {
  const factory AdherenceLog({
    @JsonKey(name: 'log_date') required String logDate,
    @JsonKey(name: 'total_scheduled') required int totalScheduled,
    @JsonKey(name: 'total_taken') required int totalTaken,
    @JsonKey(name: 'total_missed') required int totalMissed,
    @JsonKey(name: 'total_skipped') required int totalSkipped,
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
