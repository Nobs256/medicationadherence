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
  final response = await api.get('/users', params: {'role': 'doctor'});
  final List<dynamic> data = response['data'] ?? [];
  return data.map((json) => UserProfile.fromJson(json as Map<String, dynamic>)).toList();
}

@riverpod
Future<List<UserProfile>> hospitalPatients(HospitalPatientsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/users', params: {'role': 'patient'});
  final List<dynamic> data = response['data'] ?? [];
  return data.map((json) => UserProfile.fromJson(json as Map<String, dynamic>)).toList();
}

@riverpod
class HospitalActions extends _$HospitalActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> addUser(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post('/users', data: data);
      
      if (data['role'] == 'doctor') {
        ref.invalidate(hospitalDoctorsProvider);
      } else {
        ref.invalidate(hospitalPatientsProvider);
      }
      ref.invalidate(adminStatsProvider);
    });
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
