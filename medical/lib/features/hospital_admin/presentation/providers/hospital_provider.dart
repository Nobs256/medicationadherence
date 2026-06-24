import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../../auth/domain/models/user_profile.dart';

part 'hospital_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> adminStats(AdminStatsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/dashboard');
  return response['data'] as Map<String, dynamic>;
}

@riverpod
Future<List<UserProfile>> hospitalDoctors(HospitalDoctorsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  // Admins need to see both active and inactive doctors to manage them
  final response = await api.get(
    '/users',
    params: {'role': 'doctor', 'include_inactive': '1'},
  );
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<UserProfile>> hospitalPatients(HospitalPatientsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get(
    '/users',
    params: {'role': 'patient', 'include_inactive': '1'},
  );
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<List<UserProfile>> doctorAssignedPatients(
  DoctorAssignedPatientsRef ref,
  int doctorId,
) async {
  final api = ref.watch(apiServiceProvider);
  // Assuming the API supports filtering patients by doctor_id
  final response = await api.get(
    '/users',
    params: {'role': 'patient', 'doctor_id': doctorId},
  );
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
class HospitalActions extends _$HospitalActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Map<String, dynamic>?> addUser(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    Map<String, dynamic>? result;
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      final response = await api.post('/users', data: data);
      result = response['data'] as Map<String, dynamic>?;

      if (data['role'] == 'doctor') {
        ref.invalidate(hospitalDoctorsProvider);
      } else {
        ref.invalidate(hospitalPatientsProvider);
      }
      ref.invalidate(adminStatsProvider);
    });
    return result;
  }

  Future<void> assignPatient(int patientId, int doctorId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/users/$patientId/assign', data: {'doctor_id': doctorId});
      ref.invalidate(hospitalPatientsProvider);
    });
  }

  Future<void> toggleUserActive(int userId) async {
    final api = ref.read(apiServiceProvider);
    await api.post('/users/$userId/toggle');
  }
}
