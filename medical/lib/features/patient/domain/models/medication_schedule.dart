import 'package:freezed_annotation/freezed_annotation.dart';

part 'medication_schedule.freezed.dart';
part 'medication_schedule.g.dart';

@freezed
class MedicationSchedule with _$MedicationSchedule {
  const factory MedicationSchedule({
    @JsonKey(fromJson: _intFromJson) required int id,
    @JsonKey(name: 'scheduled_time') required String scheduledTime,
    required String status, // pending, taken, missed, skipped
    @JsonKey(name: 'confirmed_at') String? confirmedAt,
    String? notes,
    required String dosage,
    @JsonKey(name: 'medication_name') required String medicationName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'prescription_id', fromJson: _intFromDynamic)
    int? prescriptionId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    String? diagnosis,
    @JsonKey(name: 'lifestyle_tips') List<Map<String, String>>? lifestyleTips,
  }) = _MedicationSchedule;

  factory MedicationSchedule.fromJson(Map<String, dynamic> json) =>
      _$MedicationScheduleFromJson(json);
}

bool _boolFromInt(dynamic val) =>
    val == 1 || val == true || val == "1" || val == "true";

int _boolToInt(bool val) => val ? 1 : 0;

int _intFromJson(dynamic val) =>
    val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

int? _intFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  return int.tryParse(val.toString());
}
