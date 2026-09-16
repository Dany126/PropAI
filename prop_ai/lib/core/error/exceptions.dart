class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData;

  const ServerException({
    required this.message,
    this.statusCode,
    this.responseData,
  });
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error']);
}

class AiException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  const AiException({required this.message, this.code, this.statusCode});
}
