import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

/// A function that converts a raw, decoded JSON value (a [Map], [List],
/// [String], [num], [bool], or `null`) into a value of type [T].
///
/// Typically this is a model's `fromJson` factory, wrapped to accept
/// `dynamic` and perform the necessary cast, e.g.:
///
/// ```dart
/// (json) => UserModel.fromJson(json as Map<String, dynamic>)
/// ```
typedef JsonDecoder<T> = T Function(dynamic json);

/// Provides a unified interface for making HTTP requests.
///
/// Implementations are responsible for handling connectivity and
/// converting network errors into [Failure] instances.
///
/// Each method accepts an optional [decoder] used to convert the raw
/// response body into [T]. When omitted, the raw response body is cast
/// directly to [T] (suitable for `dynamic`, `Map<String, dynamic>`,
/// `List<dynamic>`, or `void`/`null` responses). Freezed or otherwise
/// generated models should always supply their `fromJson` via [decoder].
abstract interface class ApiClient {
  /// Sends a GET request to [path].
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  });

  /// Sends a POST request to [path].
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  });

  /// Sends a PUT request to [path].
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  });

  /// Sends a PATCH request to [path].
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  });

  /// Sends a DELETE request to [path].
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  });
}
