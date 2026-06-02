import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital.freezed.dart';
part 'hospital.g.dart';

@freezed
class Hospital with _$Hospital {
  const factory Hospital({
    required int id,
    required String name,
    String? address,
    String? phone,
    String? email,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) required bool isActive,
    @JsonKey(name: 'doctor_count') int? doctorCount,
    @JsonKey(name: 'patient_count') int? patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic) double? avgAdherence,
  }) = _Hospital;

  factory Hospital.fromJson(Map<String, dynamic> json) => _$HospitalFromJson(json);
}

bool _boolFromInt(dynamic val) => val == 1 || val == true || val == "1";
double? _doubleFromDynamic(dynamic val) {
  if (val == null) return null;
  return double.tryParse(val.toString());
}