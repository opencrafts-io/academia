import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

/// Provides a unified interface for making HTTP requests.
///
/// Implementations are responsible for handling connectivity and
/// converting network errors into [Failure] instances.
abstract interface class ApiClient {
  /// Sends a GET request to [path].
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Sends a POST request to [path].
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Sends a PUT request to [path].
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Sends a PATCH request to [path].
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Sends a DELETE request to [path].
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}
