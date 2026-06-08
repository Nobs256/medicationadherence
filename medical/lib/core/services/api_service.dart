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
  static const baseUrl =
      'https://music.onlineincomehub.org/meditrack-api/api/v1';

  ApiService(this._storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
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
          // Don't attempt to refresh tokens if we are already in the auth flow
          // (login/refresh) to avoid loops and confusing errors.
          final isAuthPath = e.requestOptions.path.contains('/auth/');

          if (e.response?.statusCode == 401 && !isAuthPath) {
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

  Future<Map<String, dynamic>> uploadFile(
    String path,
    File file,
    String fieldName,
  ) async {
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
    } catch (_) {
      /* Fail silently as this is a background task */
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.data == null) {
      throw ServerException(
        'The server returned an empty response.',
        response.statusCode,
      );
    }

    // If PHP returns a fatal error string or HTML instead of JSON, catch it here
    if (response.data is! Map) {
      throw ServerException(
        'Data Format Error: Server returned ${response.data.runtimeType} instead of JSON. This usually means a server-side crash or an HTML error page.',
        response.statusCode,
      );
    }

    final data = response.data as Map<String, dynamic>;

    // Check for application-level failures (success: false)
    if (data.containsKey('success') && data['success'] == false) {
      throw ServerException(
        data['message']?.toString() ?? 'Server operation failed',
        response.statusCode,
      );
    }

    return data;
  }

  AppException _handleError(DioException e) {
    String message = 'An unexpected error occurred';

    // Handle specific Dio error types for better feedback
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      message =
          'Connection timed out. Please check your internet and try again.';
    } else if (e.type == DioExceptionType.connectionError) {
      message =
          'Network error: Cannot reach the server. Check your connection or server status.';
    } else if (e.type == DioExceptionType.cancel) {
      message = 'Request was cancelled.';
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;

      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map) {
          // Standard API error response
          message = data['message']?.toString() ?? 'Server Error ($statusCode)';
        } else {
          // On PHP 7.4, a crash often outputs a raw string. Show a snippet to help debug.
          final rawBody = data.toString();
          final snippet =
              rawBody.length > 200
                  ? '${rawBody.substring(0, 200)}...'
                  : rawBody;
          message =
              'Server Error ($statusCode): Invalid format. Response: $snippet';
        }
      } else {
        message = 'Server Error (Status: $statusCode)';
      }
    } else {
      message = e.message ?? message;
    }

    return ServerException(message, e.response?.statusCode);
  }
}
