import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required int id,
    @JsonKey(name: 'appointment_date') required String appointmentDate,
    required String purpose,
    String? notes,
    required String status, // scheduled, completed, cancelled, rescheduled
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'patient_avatar') String? patientAvatar,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'hospital_name') String? hospitalName,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}
