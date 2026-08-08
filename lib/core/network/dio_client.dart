import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:academia/config/config.dart';
import 'package:logger/logger.dart';

class DioClient {
  late Dio dio;

  final AuthLocalDatasource authLocalDatasource;
  final DioRequestInspector? requestInspector;

  /// Ensure that before instantiating a [DioClient] you have injected the flavor.
  DioClient(
    FlavorConfig flavor, {
    required this.authLocalDatasource,
    required this.requestInspector,
  }) {
    dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 45),
        sendTimeout: Duration(seconds: 30),
        baseUrl: flavor.apiBaseUrl,
        preserveHeaderCase: true,
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) => status! < 500,
      ),
    );

    if (requestInspector != null) {
      dio.interceptors.add(requestInspector!.getDioRequestInterceptor());
    }

    _addAuthInterceptor();
  }

  void _addAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.extra['skipAuth'] == true) {
            handler.next(options);
            return;
          }

          final tokenResult = await authLocalDatasource.getTokenByProvider(
            'verisafe',
          );

          tokenResult.fold(
            (failure) {
              // No token stored (user is not logged in). Continue without
              // an Authorization header and let the API return 401, which
              // the refresh interceptor or the UI can handle appropriately.
              Logger().w(
                'No token for request to ${options.path}: ${failure.message}',
              );

              options.cancelToken?.cancel(
                "Unauthenticated request rejected. "
                "Add auth credentials or enable skipAuth.",
              );

              handler.reject(
                DioException.requestCancelled(
                  requestOptions: options,
                  reason:
                      "Unauthenticated request rejected. "
                      "Add auth credentials or enable skipAuth.",
                ),
              );
            },
            (token) {
              options.headers['Authorization'] = 'Bearer ${token.accessToken}';
              handler.next(options);
            },
          );
        },
      ),
    );
  }
}
