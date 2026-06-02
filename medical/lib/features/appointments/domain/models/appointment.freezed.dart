// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'appointment_date')
  String get appointmentDate => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // scheduled, completed, cancelled, rescheduled
  @JsonKey(name: 'patient_name')
  String? get patientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_avatar')
  String? get patientAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_name')
  String? get doctorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_name')
  String? get hospitalName => throw _privateConstructorUsedError;

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
    Appointment value,
    $Res Function(Appointment) then,
  ) = _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'appointment_date') String appointmentDate,
    String purpose,
    String? notes,
    String status,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'patient_avatar') String? patientAvatar,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'hospital_name') String? hospitalName,
  });
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentDate = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? status = null,
    Object? patientName = freezed,
    Object? patientAvatar = freezed,
    Object? doctorName = freezed,
    Object? hospitalName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            appointmentDate:
                null == appointmentDate
                    ? _value.appointmentDate
                    : appointmentDate // ignore: cast_nullable_to_non_nullable
                        as String,
            purpose:
                null == purpose
                    ? _value.purpose
                    : purpose // ignore: cast_nullable_to_non_nullable
                        as String,
            notes:
                freezed == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            patientName:
                freezed == patientName
                    ? _value.patientName
                    : patientName // ignore: cast_nullable_to_non_nullable
                        as String?,
            patientAvatar:
                freezed == patientAvatar
                    ? _value.patientAvatar
                    : patientAvatar // ignore: cast_nullable_to_non_nullable
                        as String?,
            doctorName:
                freezed == doctorName
                    ? _value.doctorName
                    : doctorName // ignore: cast_nullable_to_non_nullable
                        as String?,
            hospitalName:
                freezed == hospitalName
                    ? _value.hospitalName
                    : hospitalName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
    _$AppointmentImpl value,
    $Res Function(_$AppointmentImpl) then,
  ) = __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'appointment_date') String appointmentDate,
    String purpose,
    String? notes,
    String status,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'patient_avatar') String? patientAvatar,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'hospital_name') String? hospitalName,
  });
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
    _$AppointmentImpl _value,
    $Res Function(_$AppointmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentDate = null,
    Object? purpose = null,
    Object? notes = freezed,
    Object? status = null,
    Object? patientName = freezed,
    Object? patientAvatar = freezed,
    Object? doctorName = freezed,
    Object? hospitalName = freezed,
  }) {
    return _then(
      _$AppointmentImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        appointmentDate:
            null == appointmentDate
                ? _value.appointmentDate
                : appointmentDate // ignore: cast_nullable_to_non_nullable
                    as String,
        purpose:
            null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                    as String,
        notes:
            freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        patientName:
            freezed == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                    as String?,
        patientAvatar:
            freezed == patientAvatar
                ? _value.patientAvatar
                : patientAvatar // ignore: cast_nullable_to_non_nullable
                    as String?,
        doctorName:
            freezed == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                    as String?,
        hospitalName:
            freezed == hospitalName
                ? _value.hospitalName
                : hospitalName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl({
    required this.id,
    @JsonKey(name: 'appointment_date') required this.appointmentDate,
    required this.purpose,
    this.notes,
    required this.status,
    @JsonKey(name: 'patient_name') this.patientName,
    @JsonKey(name: 'patient_avatar') this.patientAvatar,
    @JsonKey(name: 'doctor_name') this.doctorName,
    @JsonKey(name: 'hospital_name') this.hospitalName,
  });

  factory _$AppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'appointment_date')
  final String appointmentDate;
  @override
  final String purpose;
  @override
  final String? notes;
  @override
  final String status;
  // scheduled, completed, cancelled, rescheduled
  @override
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @override
  @JsonKey(name: 'patient_avatar')
  final String? patientAvatar;
  @override
  @JsonKey(name: 'doctor_name')
  final String? doctorName;
  @override
  @JsonKey(name: 'hospital_name')
  final String? hospitalName;

  @override
  String toString() {
    return 'Appointment(id: $id, appointmentDate: $appointmentDate, purpose: $purpose, notes: $notes, status: $status, patientName: $patientName, patientAvatar: $patientAvatar, doctorName: $doctorName, hospitalName: $hospitalName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.patientAvatar, patientAvatar) ||
                other.patientAvatar == patientAvatar) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.hospitalName, hospitalName) ||
                other.hospitalName == hospitalName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    appointmentDate,
    purpose,
    notes,
    status,
    patientName,
    patientAvatar,
    doctorName,
    hospitalName,
  );

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentImplToJson(this);
  }
}

abstract class _Appointment implements Appointment {
  const factory _Appointment({
    required final int id,
    @JsonKey(name: 'appointment_date') required final String appointmentDate,
    required final String purpose,
    final String? notes,
    required final String status,
    @JsonKey(name: 'patient_name') final String? patientName,
    @JsonKey(name: 'patient_avatar') final String? patientAvatar,
    @JsonKey(name: 'doctor_name') final String? doctorName,
    @JsonKey(name: 'hospital_name') final String? hospitalName,
  }) = _$AppointmentImpl;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$AppointmentImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'appointment_date')
  String get appointmentDate;
  @override
  String get purpose;
  @override
  String? get notes;
  @override
  String get status; // scheduled, completed, cancelled, rescheduled
  @override
  @JsonKey(name: 'patient_name')
  String? get patientName;
  @override
  @JsonKey(name: 'patient_avatar')
  String? get patientAvatar;
  @override
  @JsonKey(name: 'doctor_name')
  String? get doctorName;
  @override
  @JsonKey(name: 'hospital_name')
  String? get hospitalName;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
