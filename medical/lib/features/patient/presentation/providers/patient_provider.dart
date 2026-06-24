import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/medication_schedule.dart';
import '../../../adherence/domain/models/adherence_log.dart';
import '../../../doctor/domain/models/prescription.dart';
import '../../../appointments/domain/models/appointment.dart';
import '../../../doctor/domain/models/lifestyle_advice.dart';

part 'patient_provider.g.dart';

@riverpod
Future<List<MedicationSchedule>> todaySchedules(TodaySchedulesRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/schedules/today');

  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => MedicationSchedule.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<Map<String, dynamic>> adherenceSummary(AdherenceSummaryRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/adherence/summary');
  return response['data'] as Map<String, dynamic>;
}

@riverpod
Future<List<Prescription>> myPrescriptions(MyPrescriptionsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/my-prescriptions');
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => Prescription.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<Prescription> prescriptionDetail(PrescriptionDetailRef ref, int id) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/prescriptions/$id');
  return Prescription.fromJson(response['data'] as Map<String, dynamic>);
}

@riverpod
Future<List<Appointment>> patientAppointments(PatientAppointmentsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/appointments');
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => Appointment.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<Prescription>> patientLifestyleAdvice(
    PatientLifestyleAdviceRef ref) async {
  final prescriptions = await ref.watch(myPrescriptionsProvider.future);
  // The `myPrescriptionsProvider` now fetches prescriptions with advice included.
  // We just filter for active ones.
  return prescriptions.where((p) => p.isActive).toList();
}

@riverpod
class ScheduleAction extends _$ScheduleAction {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> markTaken(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/schedules/$id/take');
      ref.invalidate(todaySchedulesProvider);
    });;
  }
}
