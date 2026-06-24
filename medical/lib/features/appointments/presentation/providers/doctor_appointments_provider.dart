import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/appointment.dart';

part 'doctor_appointments_provider.g.dart';

/// Doctor-scoped appointments (backend filters by role via JWT).
@riverpod
Future<List<Appointment>> doctorAppointments(DoctorAppointmentsRef ref, {String? status}) async {

  final api = ref.watch(apiServiceProvider);
  final response = await api.get(
    '/appointments',
    params: status != null ? {'status': status} : null,
  );

  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => Appointment.fromJson(json as Map<String, dynamic>))
      .toList();
}

