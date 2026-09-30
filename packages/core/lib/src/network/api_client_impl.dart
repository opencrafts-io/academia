import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ApiClient)
class DioApiClient
    with ConnectivityChecker, DioErrorHandler
    implements ApiClient {
  DioApiClient({required this._dio});

  final Dio _dio;

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) {
    return _request<T>(
      () => _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
      decoder: decoder,
    );
  }

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) {
    return _request<T>(
      () => _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
      decoder: decoder,
    );
  }

  @override
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) {
    return _request<T>(
      () => _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
      decoder: decoder,
    );
  }

  @override
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) {
    return _request<T>(
      () => _dio.patch<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
      decoder: decoder,
    );
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    JsonDecoder<T>? decoder,
  }) {
    return _request<T>(
      () => _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
      decoder: decoder,
    );
  }

  /// Executes [request], guarding against connectivity issues, mapping
  /// Dio errors to [Failure]s, and converting the raw response body to
  /// [T] via [decoder] (or a direct cast when no decoder is supplied).
  Future<Either<Failure, T>> _request<T>(
    Future<Response<dynamic>> Function() request, {
    required JsonDecoder<T>? decoder,
  }) async {
    if (!await isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: 'No internet connection. Please check your network.',
          error: Exception('No Internet Connection'),
        ),
      );
    }
    try {
      final response = await request();
      final statusCode = response.statusCode;
      if (statusCode != null && statusCode >= 400) {
        return left(_failureForResponse(response));
      }
      final rawData = response.data;
      final result = decoder != null ? decoder(rawData) : rawData as T;
      return right(result);
    } on DioException catch (e) {
      return handleDioError<T>(e);
    } on TypeError catch (e, s) {
      // Thrown when `decoder`/the fallback cast can't produce a [T]
      // from the raw response body (e.g. unexpected shape or a
      // missing decoder for a non-primitive T).
      return left(
        Failure.validation(
          message: 'Failed to parse response for type $T',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }

  Options? _options(Map<String, String>? headers) {
    if (headers == null) return null;
    return Options(headers: headers);
  }

  Failure _failureForResponse(Response<dynamic> response) {
    final statusCode = response.statusCode ?? 500;
    final message = _responseMessage(response.data, statusCode);
    final metadata = {'statusCode': statusCode};

    if (statusCode == 400) {
      return Failure.validation(message: message, metadata: metadata);
    }
    if (statusCode == 401 || statusCode == 403) {
      return Failure.auth(
        message: message,
        statusCode: statusCode,
        metadata: metadata,
      );
    }
    return Failure.server(
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  String _responseMessage(dynamic data, int statusCode) {
    if (data is String && data.trim().isNotEmpty) return data;
    if (data is Map) {
      for (final key in const ['message', 'detail', 'error']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return value;
      }

      final validationDetails = data.entries
          .map((entry) {
            final value = entry.value;
            if (value is List) return '${entry.key}: ${value.join(', ')}';
            if (value is String) return '${entry.key}: $value';
            return null;
          })
          .whereType<String>()
          .toList();
      if (validationDetails.isNotEmpty) return validationDetails.join('\n');
    }
    if (statusCode == 404) return 'The requested item was not found.';
    return 'Request failed ($statusCode). Please try again.';
  }
}
