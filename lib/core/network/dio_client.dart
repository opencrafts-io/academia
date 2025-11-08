import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
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
  DioRequestInspector requestInspector;

  /// Ensure that before instanciating a DioClient that
  /// you must have injected the flavor
  DioClient(
    FlavorConfig flavor, {
    required this.authLocalDatasource,
    required this.requestInspector,
  }) {
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

    dio.interceptors.add(requestInspector.getDioRequestInterceptor());

    // NOTE: Do not push the loggin version it pollutes the logs!
    // Use the inbuilt ui inspector
    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     error: true,
    //     responseBody: true,
    //     request: true,
    //     requestBody: true,
    //     requestHeader: true,
    //     responseHeader: true,
    //     maxWidth: 90,
    //     compact: true,
    //     enabled: kDebugMode,
    //   ),
    // );
    //
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
              Logger().w('No authentication token found: ${failure.message}');
              if (kDebugMode) {
                print('Auth interceptor: ${failure.message}');
                // Uncomment the next 3 lines to test with a dummy token
                // options.headers.addAll({
                //   "Authorization": 'Bearer dummy-token-for-testing',
                // });
              }
              // Continue without auth header - let the API return 401
              handler.next(options);
            },
            (token) {
              Logger().i('Adding auth token for request to: ${options.path}');
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
