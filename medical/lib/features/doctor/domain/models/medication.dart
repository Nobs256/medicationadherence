import 'package:freezed_annotation/freezed_annotation.dart';

part 'medication.freezed.dart';
part 'medication.g.dart';

@freezed
class Medication with _$Medication {
  const factory Medication({
    @JsonKey(fromJson: _intFromJson) required int id,
    @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic) int? hospitalId,
    required String name,
    @JsonKey(name: 'generic_name') String? genericName,
    String? description,
    String? category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_by_name') String? createdByName,
  }) = _Medication;

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);
}

int _intFromJson(dynamic val) =>
    val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

int? _intFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  return int.tryParse(val.toString());
}
