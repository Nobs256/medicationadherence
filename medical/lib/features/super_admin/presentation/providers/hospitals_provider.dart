import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/models/hospital.dart';

part 'hospitals_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> superAdminStats(SuperAdminStatsRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final json = await api.get('/dashboard');
  return (json['data'] as Map<String, dynamic>?) ?? {};
}

@riverpod
Future<List<Hospital>> hospitalsList(HospitalsListRef ref) async {
  final api = ref.watch(apiServiceProvider);
  final json = await api.get('/hospitals');
  final List<dynamic> data = json['data'] ?? [];
  return data
      .map((json) => Hospital.fromJson(json as Map<String, dynamic>))
      .toList();
}

@riverpod
Future<Hospital> hospitalDetail(HospitalDetailRef ref, int id) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.get('/hospitals/$id');
  return Hospital.fromJson(response['data'] as Map<String, dynamic>);
}

@riverpod
class HospitalActions extends _$HospitalActions {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> addHospital({
    required String name,
    String? address,
    String? email,
    File? logo,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      final data = {'name': name, 'address': address, 'email': email};
      // Note: If logo exists, implementation would use api.uploadFile
      await api.post('/hospitals', data: data);
      ref.invalidate(hospitalsListProvider);
    });
  }

  Future<void> toggleHospital(int id) async {
    final api = ref.read(apiServiceProvider);
    await api.post('/hospitals/$id/toggle');
    ref.invalidate(hospitalsListProvider);
  }
}
