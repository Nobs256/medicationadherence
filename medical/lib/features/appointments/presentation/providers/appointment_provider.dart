import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/appointment.dart';
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

  Future<void> scheduleAppointment(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/appointments', data: data);

      // Refresh relevant data
      ref.invalidate(appointmentsProvider);
      ref.invalidate(doctorStatsProvider);
    });
  }

  Future<void> updateStatus(int id, String status) async {
    final api = ref.read(apiServiceProvider);
    await api.put('/appointments/$id', data: {'status': status});
    ref.invalidate(appointmentsProvider);
  }
}
