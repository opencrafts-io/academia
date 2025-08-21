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
            message: "Hello, is it me you're looking for? Connection refused by server. It seems like nobody's home!",
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
            message: "Slow ride, take it easy! Sending request took too long. We need to slow down and try again!",
            error: de,
          ),
        );

      default:
        return left(
          NetworkFailure(
            message:
                de.response?.data["error"] ??
                de.response?.data["message"] ??
                de.response?.statusMessage ??
                // "Don't stop believin'" - Journey
                "Don't stop believin'! An unexpected error occurred, but don't stop believing! Please try again later.",
            error: de,
          ),
        );
    }
  }
}
