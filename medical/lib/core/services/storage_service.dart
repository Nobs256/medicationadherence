import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider((ref) => StorageService());

class StorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async =>
      await _storage.write(key: key, value: value);
  Future<String?> read(String key) async => await _storage.read(key: key);
  Future<void> delete(String key) async => await _storage.delete(key: key);
  Future<void> deleteAll() async => await _storage.deleteAll();

  // Helpers for common keys
  Future<String?> getAccessToken() => read('access_token');
  Future<String?> getRefreshToken() => read('refresh_token');
  Future<bool> hasToken() async => (await getAccessToken()) != null;
}
