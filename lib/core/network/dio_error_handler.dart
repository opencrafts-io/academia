import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin DioErrorHandler {
  Either<Failure, T> handleDioError<T>(DioException de) {
    switch (de.type) {
      case DioExceptionType.connectionError:
        return left(
          NetworkFailure(
            message: "Connection refused by server please try again later",
            error: de,
          ),
        );
      case DioExceptionType.connectionTimeout:
        return left(
          NetworkFailure(
            message:
                "Server took too long to respond, please try after a few minutes",
            error: de,
          ),
        );
      case DioExceptionType.receiveTimeout:
        return left(
          NetworkFailure(
            message:
                "Server did not send a response in time, please try again later.",
            error: de,
          ),
        );
      case DioExceptionType.sendTimeout:
        return left(
          NetworkFailure(
            message: "Sending request took too long, please try again later.",
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
                "An unexpected error occurred. Please try again later.",
            error: de,
          ),
        );
    }
  }
}
