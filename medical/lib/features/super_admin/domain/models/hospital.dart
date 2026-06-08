import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital.freezed.dart';
part 'hospital.g.dart';

@freezed
class Hospital with _$Hospital {
  const factory Hospital({
    @JsonKey(fromJson: _intFromJson) required int id,
    required String name,
    String? address,
    String? phone,
    String? email,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt) required bool isActive,
    @JsonKey(name: 'doctor_count', fromJson: _intFromDynamic) int? doctorCount,
    @JsonKey(name: 'patient_count', fromJson: _intFromDynamic)
    int? patientCount,
    @JsonKey(name: 'avg_adherence', fromJson: _doubleFromDynamic)
    double? avgAdherence,
  }) = _Hospital;

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);
}

bool _boolFromInt(dynamic val) =>
    val == 1 || val == true || val == "1" || val == "true";

int _intFromJson(dynamic val) =>
    val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

int? _intFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  return int.tryParse(val.toString());
}

double? _doubleFromDynamic(dynamic val) {
  if (val == null) return null;
  if (val is num) return val.toDouble();
  return double.tryParse(val.toString());
}
