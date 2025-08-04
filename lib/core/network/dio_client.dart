import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/config/config.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  /// The DioClient
  ///
  /// Will be used to send requests to the server
  late Dio dio;
  AuthLocalDatasource authLocalDatasource;

  /// Ensure that before instanciating a DioClient that
  /// you must have injected the flavor
  DioClient(FlavorConfig flavor, {required this.authLocalDatasource}) {
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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // fetch the token
          final tokenRes = await authLocalDatasource.getTokenByProvider(
            "verisafe",
          );

          return tokenRes.fold(
            (failure) {
              Logger().i(failure.message, error: failure.error);
              handler.next(options);
            },
            (token) {
              options.headers.addAll({
                "Authorization": 'Bearer ${token.accessToken}',
              });
              handler.next(options);
            },
          );
        },
      ),
    );
  }
}
