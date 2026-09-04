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
  }) {
    return _request(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
    );
  }

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _request(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
    );
  }

  @override
  Future<Either<Failure, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _request(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
    );
  }

  @override
  Future<Either<Failure, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _request(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
    );
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _request(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(headers),
      ),
    );
  }

  Future<Either<Failure, T>> _request<T>(
    Future<Response<T>> Function() request,
  ) async {
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
      return right(response.data as T);
    } on DioException catch (e) {
      return handleDioError<T>(e);
    }
  }

  Options? _options(Map<String, String>? headers) {
    if (headers == null) return null;

    return Options(headers: headers);
  }
}
