import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin DioErrorHandler {
  Either<Failure, T> handleDioError<T>(DioException de) {
    switch (de.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return left(
          NetworkFailure(
            message: "The request timed out. Please check your internet connection and try again.",
            error: de,
          ),
        );

      case DioExceptionType.connectionError:
        return left(
          NetworkFailure(
            message: "Unable to connect to the server. Please verify your connection or try again later.",
            error: de,
          ),
        );

      case DioExceptionType.badResponse:
        // Extracts the server's custom error message if available, otherwise defaults
        final serverMessage =
            de.response?.data?['message'] ?? de.response?.data?['error'];
        final statusCode = de.response?.statusCode;

        return left(
          ServerFailure(
            message:
                serverMessage?.toString() ??
                "Server error ($statusCode). Please try again.",
            error: de,
          ),
        );

      case DioExceptionType.cancel:
        return left(
          NetworkFailure(message: "The request was cancelled.", error: de),
        );

      case DioExceptionType.badCertificate:
        return left(
          ServerFailure(
            message:
                "A secure connection could not be established with the server.",
            error: de,
          ),
        );

      default:
        return left(
          NetworkFailure(
            message: "An unexpected network error occurred. Please try again.",
            error: de,
          ),
        );
    }
  }
}
