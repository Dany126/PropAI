import 'package:equatable/equatable.dart';

/// Base Failure class extending Equatable for simple test assertion comparisons
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const Failure({required this.message, this.statusCode, this.originalError});

  @override
  List<Object?> get props => [message, statusCode, originalError];
}

// ==========================================
// 1. GENERAL & NETWORK FAILURES
// ==========================================

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.statusCode,
    super.originalError,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Connection timed out. Please try again.',
    super.statusCode,
    super.originalError,
  });
}

class CancelledFailure extends Failure {
  const CancelledFailure({
    super.message = 'Request was cancelled.',
    super.statusCode,
    super.originalError,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred.',
    super.statusCode,
    super.originalError,
  });
}

// ==========================================
// 2. CUSTOM BACKEND / REST API FAILURES
// ==========================================

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode = 500,
    super.originalError,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Session expired or invalid token. Please log in again.',
    super.statusCode = 401,
    super.originalError,
  });
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    super.message = 'You do not have permission to perform this action.',
    super.statusCode = 403,
    super.originalError,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Requested resource was not found.',
    super.statusCode = 404,
    super.originalError,
  });
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.statusCode = 422,
    super.originalError,
  });

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

class ConflictFailure extends Failure {
  const ConflictFailure({
    super.message = 'A conflict occurred with existing data.',
    super.statusCode = 409,
    super.originalError,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to load or save local cache.',
    super.statusCode,
    super.originalError,
  });
}

// ==========================================
// 3. AI-SPECIFIC API FAILURES
// ==========================================

/// Rate limit exceeded (HTTP 429 / RPM or TPM limits)
class AiRateLimitFailure extends Failure {
  final Duration? retryAfter;

  const AiRateLimitFailure({
    super.message =
        'AI rate limit exceeded. Please wait a moment and try again.',
    this.retryAfter,
    super.statusCode = 429,
    super.originalError,
  });

  @override
  List<Object?> get props => [...super.props, retryAfter];
}

/// Prompt + context exceeds the LLM context window / token limit
class AiContextWindowExceededFailure extends Failure {
  const AiContextWindowExceededFailure({
    super.message = 'Conversation or query is too long for the AI model.',
    super.statusCode = 400,
    super.originalError,
  });
}

/// Prompt or response violated safety/content moderation policies
class AiSafetyFilterFailure extends Failure {
  final String? safetyCategory;

  const AiSafetyFilterFailure({
    super.message = 'Request flagged by content safety policies.',
    this.safetyCategory,
    super.statusCode,
    super.originalError,
  });

  @override
  List<Object?> get props => [...super.props, safetyCategory];
}

/// Quota exhausted (Credits depleted or billing tier expired)
class AiQuotaExhaustedFailure extends Failure {
  const AiQuotaExhaustedFailure({
    super.message =
        'AI usage quota has been exhausted. Check your plan/billing.',
    super.statusCode = 402,
    super.originalError,
  });
}

/// LLM returned unparsable output (e.g. malformed JSON when structured output was requested)
class AiMalformedOutputFailure extends Failure {
  const AiMalformedOutputFailure({
    super.message = 'Failed to parse AI structured response.',
    super.statusCode,
    super.originalError,
  });
}

/// Model is currently overloaded or undergoing maintenance (e.g. 503 Overloaded)
class AiModelOverloadedFailure extends Failure {
  const AiModelOverloadedFailure({
    super.message =
        'The AI model is currently overloaded. Please try again shortly.',
    super.statusCode = 503,
    super.originalError,
  });
}

/// Prompt hallucination / Grounding fallback (used in RAG systems when confidence is too low)
class AiUnverifiedResponseFailure extends Failure {
  const AiUnverifiedResponseFailure({
    super.message = 'Not enough verified data to answer this query safely.',
    super.statusCode,
    super.originalError,
  });
}
