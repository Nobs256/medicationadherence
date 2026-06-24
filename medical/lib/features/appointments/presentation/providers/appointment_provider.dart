import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/appointment.dart';
import '../../../patient/presentation/providers/patient_provider.dart';
import '../../../doctor/presentation/providers/doctor_providers.dart';

part 'appointment_provider.g.dart';

@riverpod
Future<List<Appointment>> appointments(
  AppointmentsRef ref, {
  String? status,
}) async {
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

@riverpod
class AppointmentActions extends _$AppointmentActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> _mutateAppointments(Future<void> Function() mutation) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await mutation();

      // Refresh relevant data
      ref.invalidate(appointmentsProvider);
      ref.invalidate(patientAppointmentsProvider);
      ref.invalidate(doctorStatsProvider);
    });
  }

  Future<void> scheduleAppointment(Map<String, dynamic> data) async {
    await _mutateAppointments(() async {
      await ref.read(apiServiceProvider).post('/appointments', data: data);
    });
  }

  Future<void> requestAppointment(Map<String, dynamic> data) async {
    await _mutateAppointments(() async {
      await ref.read(apiServiceProvider).post('/appointments', data: data);
    });
  }

  Future<void> updateAppointment(int id, Map<String, dynamic> data) async {
    // Not showing a global loading indicator for this action for a smoother UX.
    await ref.read(apiServiceProvider).put('/appointments/$id', data: data);
    ref.invalidate(appointmentsProvider);
    ref.invalidate(patientAppointmentsProvider);
    ref.invalidate(doctorStatsProvider);
  }

  Future<void> updateStatus(int id, String status) async {
    await updateAppointment(id, {'status': status});
  }
}
