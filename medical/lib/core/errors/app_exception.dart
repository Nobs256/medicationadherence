class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException() : super('No internet connection');
}

class ServerException extends AppException {
  final dynamic data;
  ServerException(super.message, [super.code, this.data]);
}
