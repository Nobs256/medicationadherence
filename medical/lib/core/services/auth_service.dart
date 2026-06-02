import 'dart:io';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';
import 'storage_service.dart';
import '../../features/auth/domain/models/user_profile.dart';

final authServiceProvider = Provider(
  (ref) => AuthService(
    ref.read(apiServiceProvider),
    ref.read(storageServiceProvider),
  ),
);

class AuthService {
  final ApiService _api;
  final StorageService _storage;

  AuthService(this._api, this._storage);

  Future<UserProfile> login(String email, String password) async {
    final response = await _api.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final data = response['data'] as Map<String, dynamic>;

    // Save tokens
    await _storage.write('access_token', data['access_token'].toString());
    await _storage.write('refresh_token', data['refresh_token'].toString());

    // Parse and save user profile
    final user = UserProfile.fromJson(data['user'] as Map<String, dynamic>);
    await _storage.write('user_profile', jsonEncode(user.toJson()));

    return user;
  }

  Future<void> logout() async {
    try {
      await _api.post('/auth/logout');
    } catch (_) {}
    await _storage.deleteAll();
  }

  Future<UserProfile?> getCachedProfile() async {
    final raw = await _storage.read('user_profile');
    if (raw == null) return null;
    return UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<UserProfile> updateProfile(Map<String, dynamic> data) async {
    await _api.put('/profile', data: data);
    return fetchAndCacheProfile();
  }

  Future<UserProfile> fetchAndCacheProfile() async {
    final response = await _api.get('/profile');
    final user = UserProfile.fromJson(response['data'] as Map<String, dynamic>);
    await _storage.write('user_profile', jsonEncode(user.toJson()));
    return user;
  }

  Future<String> uploadAvatar(File file) async {
    final response = await _api.uploadFile('/profile/avatar', file, 'avatar');
    final url = response['data']['avatar_url'].toString();
    // Refresh local cache to ensure UI is in sync
    await fetchAndCacheProfile();
    return url;
  }

  Future<bool> isAuthenticated() => _storage.hasToken();
}
