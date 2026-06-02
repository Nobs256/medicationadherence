import 'package:freezed_annotation/freezed_annotation.dart';

part 'medication.freezed.dart';
part 'medication.g.dart';

@freezed
class Medication with _$Medication {
  const factory Medication({
    required int id,
    @JsonKey(name: 'hospital_id') int? hospitalId,
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
