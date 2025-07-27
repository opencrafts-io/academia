import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/config/config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  /// The DioClient
  ///
  /// Will be used to send requests to the server
  late Dio dio;

  /// Ensure that before instanciating a DioClient that
  /// you must have injected the flavor
  DioClient(FlavorConfig flavor) {
    dio = Dio(
      BaseOptions(
        baseUrl: flavor.apiBaseUrl,
        preserveHeaderCase: true,
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        responseBody: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        maxWidth: 90,
        compact: true,
        enabled: kDebugMode,
      ),
    );

    _addAuthInterceptor();
  }

  void _addAuthInterceptor() {
    // dio.interceptors.add(AuthInterceptor());
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
