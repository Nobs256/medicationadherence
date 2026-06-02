// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: (json['id'] as num).toInt(),
      appointmentDate: json['appointment_date'] as String,
      purpose: json['purpose'] as String,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      patientName: json['patient_name'] as String?,
      patientAvatar: json['patient_avatar'] as String?,
      doctorName: json['doctor_name'] as String?,
      hospitalName: json['hospital_name'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_date': instance.appointmentDate,
      'purpose': instance.purpose,
      'notes': instance.notes,
      'status': instance.status,
      'patient_name': instance.patientName,
      'patient_avatar': instance.patientAvatar,
      'doctor_name': instance.doctorName,
      'hospital_name': instance.hospitalName,
    };
