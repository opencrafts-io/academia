import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ChirpDioClient {
  /// The DioClient specifically for Chirp service
  ///
  /// Will be used to send requests to the chirp server
  late Dio dio;
  AuthLocalDatasource authLocalDatasource;

  /// Chirp service base URL
  static const String chirpBaseUrl = 'https://qachirp.opencrafts.io';

  ChirpDioClient({required this.authLocalDatasource}) {
    dio = Dio(
      BaseOptions(
        baseUrl: chirpBaseUrl,
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
