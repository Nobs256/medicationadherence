import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/api_service.dart';
import '../../domain/models/user.dart';

part 'hospital_admins_provider.g.dart';


@riverpod
Future<List<HospitalAdmin>> hospitalAdmins(HospitalAdminsRef ref, int hospitalId) async {
  final api = ref.watch(apiServiceProvider);


  final json = await api.get(
    '/users',
    params: {
      'role': 'hospital_admin',
      'hospital_id': hospitalId,
    },
  );

  final List<dynamic> data = json['data'] ?? [];
  return data
      .map((e) => HospitalAdmin.fromJson(e as Map<String, dynamic>))
      .toList();
}

@riverpod
class HospitalAdminActions extends _$HospitalAdminActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> createHospitalAdmin({
    required int hospitalId,
    required String fullName,
    required String email,
    String? phone,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      await api.post(
        '/users',
        data: {
          'full_name': fullName,
          'email': email,
          'role': 'hospital_admin',
          'hospital_id': hospitalId,
          'phone': phone ?? '',
        },
      );
    });

    ref.invalidate(hospitalAdminsProvider(hospitalId));
  }

  Future<void> toggleAdmin(int userId, int hospitalId) async {
    final api = ref.read(apiServiceProvider);
    await api.post('/users/$userId/toggle');
    ref.invalidate(hospitalAdminsProvider(hospitalId));
  }
}


