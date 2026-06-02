import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage_service.dart';
import '../errors/app_exception.dart';

final apiServiceProvider = Provider(
  (ref) => ApiService(ref.read(storageServiceProvider)),
);

class ApiService {
  final StorageService _storage;
  late final Dio _dio;

  // Replace with your local IP or production domain
  static const baseUrl = 'https://meditrack-api/api/v1';

  ApiService(this._storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final success = await _refreshToken();
            if (success) {
              final retryOptions = e.requestOptions;
              final token = await _storage.getAccessToken();
              retryOptions.headers['Authorization'] = 'Bearer $token';
              return handler.resolve(await _dio.fetch(retryOptions));
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refresh = await _storage.getRefreshToken();
      if (refresh == null) return false;

      final response = await Dio().post(
        '$baseUrl/auth/refresh',
        data: {'refresh_token': refresh},
      );
      final data = response.data['data'] as Map<String, dynamic>;

      await _storage.write('access_token', data['access_token'].toString());
      await _storage.write('refresh_token', data['refresh_token'].toString());
      return true;
    } catch (_) {
      await _storage.deleteAll();
      return false;
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> uploadFile(String path, File file, String fieldName) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path),
      });
      final response = await _dio.post(path, data: formData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Triggers the internal server tasks (reminders, adherence checks)
  /// This is used as a fallback when OS-level Cron Jobs are not available.
  Future<void> triggerInternalTasks() async {
    try {
      // We just need to hit any authenticated endpoint to trigger the PHP logic
      await get('/dashboard');
    } catch (_) { /* Fail silently as this is a background task */ }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    return response.data as Map<String, dynamic>;
  }

  AppException _handleError(DioException e) {
    final message =
        e.response?.data['message']?.toString() ?? 'Network error occurred';
    return ServerException(message, e.response?.statusCode);
  }
}
