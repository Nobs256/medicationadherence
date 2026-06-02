import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/prescription.dart';
import '../../../auth/domain/models/user_profile.dart';
import '../../domain/models/medication.dart';

part 'doctor_providers.g.dart';

@riverpod
Future<Map<String, dynamic>> doctorStats(DoctorStatsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/dashboard');
  // Expected keys: patients, todayAppts, prescriptions
  return response['data'] as Map<String, dynamic>;
}

@riverpod
Future<List<UserProfile>> myPatients(MyPatientsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get(
    '/users',
    params: {'role': 'patient', 'doctor_id': 'me'},
  );
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<UserProfile> patientDetail(PatientDetailRef ref, int id) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/users/$id');
  return UserProfile.fromJson(response['data'] as Map<String, dynamic>);
}

@riverpod
Future<List<Prescription>> patientPrescriptions(
  PatientPrescriptionsRef ref,
  int id,
) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/prescriptions', params: {'patient_id': id});
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => Prescription.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<Medication>> medicationLibrary(MedicationLibraryRef ref, {String? query}) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/medications', params: {'q': query});
  final List<dynamic> data = response['data'] ?? [];
  return data.map((json) => Medication.fromJson(json as Map<String, dynamic>)).toList();
}

@riverpod
class MedicationActions extends _$MedicationActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> addMedication(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/medications', data: data);
      ref.invalidate(medicationLibraryProvider);
    });
  }
}

@riverpod
class PrescriptionActions extends _$PrescriptionActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> createPrescription(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/prescriptions', data: data);
      if (data['patient_id'] != null) {
        ref.invalidate(patientPrescriptionsProvider(data['patient_id']));
      }
      ref.invalidate(doctorStatsProvider);
    });
  }
}
