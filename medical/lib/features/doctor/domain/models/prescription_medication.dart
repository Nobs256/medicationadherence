import 'package:freezed_annotation/freezed_annotation.dart';

part 'prescription_medication.freezed.dart';
part 'prescription_medication.g.dart';

@freezed
class PrescriptionMedication with _$PrescriptionMedication {
  const factory PrescriptionMedication({
    @JsonKey(fromJson: _intFromJson) required int id,
    @JsonKey(name: 'medication_id', fromJson: _intFromJson)
    required int medicationId,
    @JsonKey(name: 'medication_name') required String medicationName,
    @JsonKey(name: 'generic_name') String? genericName,
    String? category,
    @JsonKey(name: 'medication_description') String? medicationDescription,
    @JsonKey(name: 'image_url') String? imageUrl,
    required String dosage,
    required String frequency,
    @JsonKey(name: 'times_of_day') required List<String> timesOfDay,
    @JsonKey(name: 'with_food', fromJson: _boolFromInt, toJson: _boolToInt)
    required bool withFood,
    @JsonKey(name: 'with_water', fromJson: _boolFromInt, toJson: _boolToInt)
    required bool withWater,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
    @JsonKey(name: 'duration_days', fromJson: _intFromDynamic)
    int? durationDays,
  }) = _PrescriptionMedication;

  factory PrescriptionMedication.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionMedicationFromJson(json);
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
