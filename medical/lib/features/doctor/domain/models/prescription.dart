import 'package:freezed_annotation/freezed_annotation.dart';
import 'prescription_medication.dart';
import 'lifestyle_advice.dart';

part 'prescription.freezed.dart';
part 'prescription.g.dart';

@freezed
class Prescription with _$Prescription {
  const factory Prescription({
    required int id,
    required String diagnosis,
    String? notes,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) required bool isActive,
    @JsonKey(name: 'doctor_name') required String doctorName,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'medication_count') int? medicationCount,
    @JsonKey(name: 'advice_count') int? adviceCount,
    List<PrescriptionMedication>? medications,
    @JsonKey(name: 'lifestyle_advice') List<LifestyleAdvice>? lifestyleAdvice,
  }) = _Prescription;

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);
}

bool _boolFromInt(dynamic val) => val == 1 || val == true || val == "1";