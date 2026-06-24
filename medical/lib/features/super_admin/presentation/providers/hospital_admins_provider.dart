import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../../auth/domain/models/user_profile.dart';

part 'hospital_admins_provider.g.dart';

@riverpod
Future<List<UserProfile>> hospitalAdmins(
  HospitalAdminsRef ref,
  int hospitalId,
) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get(
    '/users',
    params: {'role': 'hospital_admin', 'hospital_id': hospitalId},
  );
  final List<dynamic> data = response['data']?['data'] as List<dynamic>? ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
class HospitalAdminActions extends _$HospitalAdminActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Map<String, dynamic>?> createHospitalAdmin({
    required int hospitalId,
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    Map<String, dynamic>? result;
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      final response = await api.post(
        '/users',
        data: {
          'hospital_id': hospitalId,
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'role': 'hospital_admin',
          'password': password,
        },
      );
      result = response['data'] as Map<String, dynamic>?;
      ref.invalidate(hospitalAdminsProvider(hospitalId));
    });
    return result;
  }

  Future<void> toggleAdmin(int adminId, int hospitalId) async {
    final api = ref.read(apiServiceProvider);
    await api.post('/users/$adminId/toggle');
    ref.invalidate(hospitalAdminsProvider(hospitalId));
  }
}
