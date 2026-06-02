import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/auth_service.dart';
import '../domain/models/user_profile.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref.read(authServiceProvider)),
);

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<UserProfile> login(String email, String password) {
    return _authService.login(email, password);
  }

  Future<void> logout() => _authService.logout();

  Future<UserProfile?> getCurrentUser() => _authService.getCachedProfile();

  Future<bool> checkAuthStatus() => _authService.isAuthenticated();

  Future<UserProfile> updateProfile(Map<String, dynamic> data) =>
      _authService.updateProfile(data);

  Future<String> uploadAvatar(File file) =>
      _authService.uploadAvatar(file);
}
