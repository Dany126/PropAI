import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failures.dart';
import 'exceptions.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is Failure) {
      return error;
    }

    // 1. Handling Dio / HTTP Library Errors
    if (error is DioException) {
      return _handleDioError(error);
    }

    // 2. Handling System / Socket Errors
    if (error is SocketException) {
      return NetworkFailure(originalError: error);
    }

    if (error is TimeoutException) {
      return TimeoutFailure(originalError: error);
    }

    // 3. Custom Server Exceptions
    if (error is ServerException) {
      return _mapStatusCodeToFailure(
        statusCode: error.statusCode,
        message: error.message,
        data: error.responseData,
      );
    }

    // 4. Custom AI Exceptions (e.g. from Google GenAI, OpenAI SDKs)
    if (error is AiException) {
      return _mapAiExceptionToFailure(error);
    }

    // 5. Format/Parsing Exception
    if (error is FormatException) {
      return AiMalformedOutputFailure(
        message: 'Invalid data format or malformed AI output.',
        originalError: error,
      );
    }

    return UnknownFailure(message: error.toString(), originalError: error);
  }

  static Failure _handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(originalError: dioError);

      case DioExceptionType.connectionError:
        return NetworkFailure(originalError: dioError);

      case DioExceptionType.cancel:
        return CancelledFailure(originalError: dioError);

      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final data = dioError.response?.data;
        final message =
            _extractMessage(data) ?? dioError.message ?? 'Server error';

        // Check if error response came from an AI endpoint (e.g. Gemini / OpenAI / Custom AI gateway)
        if (_isAiErrorPayload(data)) {
          return _mapAiPayloadToFailure(statusCode, data);
        }

        return _mapStatusCodeToFailure(
          statusCode: statusCode,
          message: message,
          data: data,
          originalError: dioError,
        );

      case DioExceptionType.badCertificate:
        return const ServerFailure(
          message: 'Security certificate validation failed.',
        );

      case DioExceptionType.unknown:
      default:
        if (dioError.error is SocketException) {
          return NetworkFailure(originalError: dioError);
        }
        return UnknownFailure(
          message: dioError.message ?? 'An unknown network error occurred.',
          originalError: dioError,
        );
    }
  }

  static Failure _mapStatusCodeToFailure({
    int? statusCode,
    required String message,
    dynamic data,
    dynamic originalError,
  }) {
    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: message,
          originalError: originalError,
        );
      case 401:
        return UnauthorizedFailure(
          message: message,
          originalError: originalError,
        );
      case 403:
        return ForbiddenFailure(message: message, originalError: originalError);
      case 404:
        return NotFoundFailure(message: message, originalError: originalError);
      case 409:
        return ConflictFailure(message: message, originalError: originalError);
      case 422:
        return ValidationFailure(
          message: message,
          fieldErrors: _extractFieldErrors(data),
          originalError: originalError,
        );
      case 429:
        return AiRateLimitFailure(
          message: message,
          originalError: originalError,
        );
      case 500:
      case 502:
      default:
        return ServerFailure(
          message: message,
          statusCode: statusCode,
          originalError: originalError,
        );
    }
  }

  static Failure _mapAiExceptionToFailure(AiException aiException) {
    final code = aiException.code?.toLowerCase() ?? '';
    final msg = aiException.message.toLowerCase();

    if (code.contains('rate_limit') ||
        msg.contains('quota') ||
        aiException.statusCode == 429) {
      return AiRateLimitFailure(
        message: aiException.message,
        originalError: aiException,
      );
    }
    if (code.contains('context_length') || msg.contains('token limit')) {
      return AiContextWindowExceededFailure(
        message: aiException.message,
        originalError: aiException,
      );
    }
    if (code.contains('safety') ||
        msg.contains('blocked') ||
        msg.contains('filter')) {
      return AiSafetyFilterFailure(
        message: aiException.message,
        originalError: aiException,
      );
    }
    if (code.contains('insufficient_quota') || aiException.statusCode == 402) {
      return AiQuotaExhaustedFailure(
        message: aiException.message,
        originalError: aiException,
      );
    }
    if (code.contains('overloaded') || aiException.statusCode == 503) {
      return AiModelOverloadedFailure(
        message: aiException.message,
        originalError: aiException,
      );
    }

    return ServerFailure(
      message: aiException.message,
      statusCode: aiException.statusCode,
    );
  }

  static bool _isAiErrorPayload(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data.containsKey('error') &&
          (data['error'] is Map &&
              (data['error'].containsKey('code') ||
                  data['error'].containsKey('type')));
    }
    return false;
  }

  static Failure _mapAiPayloadToFailure(int? statusCode, dynamic data) {
    final errorObj = data['error'];
    final message = errorObj['message'] ?? 'AI service failure';
    final code = (errorObj['code'] ?? errorObj['type'] ?? '')
        .toString()
        .toLowerCase();

    if (statusCode == 429 || code.contains('rate_limit')) {
      return AiRateLimitFailure(message: message, statusCode: statusCode);
    }
    if (code.contains('context_window') || code.contains('max_tokens')) {
      return AiContextWindowExceededFailure(
        message: message,
        statusCode: statusCode,
      );
    }
    if (code.contains('safety') || code.contains('policy_violation')) {
      return AiSafetyFilterFailure(message: message, statusCode: statusCode);
    }
    if (statusCode == 402 || code.contains('quota')) {
      return AiQuotaExhaustedFailure(message: message, statusCode: statusCode);
    }
    if (statusCode == 503 || code.contains('overloaded')) {
      return AiModelOverloadedFailure(message: message, statusCode: statusCode);
    }

    return ServerFailure(message: message, statusCode: statusCode);
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error']?['message'] ?? data['detail'];
    }
    return null;
  }

  static Map<String, List<String>>? _extractFieldErrors(dynamic data) {
    if (data is Map<String, dynamic> && data['errors'] is Map) {
      final errors = data['errors'] as Map;
      return errors.map((key, value) {
        if (value is List) {
          return MapEntry(
            key.toString(),
            value.map((e) => e.toString()).toList(),
          );
        }
        return MapEntry(key.toString(), [value.toString()]);
      });
    }
    return null;
  }
}
