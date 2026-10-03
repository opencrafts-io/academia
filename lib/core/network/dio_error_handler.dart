import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin DioErrorHandler {
  Either<Failure, T> handleDioError<T>(DioException de) {
    switch (de.type) {
      case DioExceptionType.connectionError:
        return left(
          NetworkFailure(
            // "Hello, is it me you're looking for?" - Lionel Richie
            message:
                "Hello, is it me you're looking for? Connection refused by server. It seems like nobody's home!",
            error: de,
          ),
        );
      case DioExceptionType.connectionTimeout:
        return left(
          NetworkFailure(
            // "Time is on my side" - Rolling Stones
            message:
                "Time is on my side! Server took too long to respond. Time may be on our side, but not today!",
            error: de,
          ),
        );
      case DioExceptionType.receiveTimeout:
        return left(
          NetworkFailure(
            // "Waiting for a girl like you" - Foreigner
            message:
                "We're still waiting for that server response. It's taking longer than expected!",
            error: de,
          ),
        );
      case DioExceptionType.sendTimeout:
        return left(
          NetworkFailure(
            // "Slow ride, take it easy" - Foghat
            message:
                "Slow ride, take it easy! Sending request took too long. We need to slow down and try again!",
            error: de,
          ),
        );

      default:
        return left(
          NetworkFailure(
            message:
                _messageFromBody(de.response?.data) ??
                _statusMessage(de.response) ??
                // "Don't stop believin'" - Journey
                "Don't stop believin'! An unexpected error occurred, but don't stop believing! Please try again later.",
            error: de,
          ),
        );
    }
  }

  /// Pulls a human-readable message out of a JSON error body. Gateways and
  /// crashed services answer with plain text or HTML (e.g. "Bad Gateway"),
  /// so anything that isn't a map is ignored rather than indexed.
  static String? _messageFromBody(dynamic data) {
    if (data is! Map) return null;
    for (final key in const ["error", "message", "detail"]) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) return value;
    }
    return null;
  }

  static String? _statusMessage(Response<dynamic>? response) {
    if (response == null) return null;
    final code = response.statusCode;
    if (code != null && code >= 500) {
      return "The server is having trouble right now ($code). Please try again in a moment.";
    }
    final status = response.statusMessage;
    return (status == null || status.isEmpty) ? null : status;
  }
}
