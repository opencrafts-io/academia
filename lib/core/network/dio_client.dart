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

          // Gate: ensure the biometric session is unlocked before doing
          // anything. If auth is already in progress from a parallel request
          // this awaits the same Completer rather than spawning a second prompt.
          // No request is dispatched unauthenticated -- if auth fails the
          // request is rejected here rather than going out without a token.
          final authResult = await authLocalDatasource.ensureAuthenticated();

          final authFailure = authResult.fold((f) => f, (_) => null);
          if (authFailure != null) {
            Logger().w(
              'Auth gate rejected request to ${options.path}: ${authFailure.message}',
            );
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.cancel,
                error: authFailure,
                message: authFailure.message,
              ),
              true,
            );
            return;
          }

          // Auth passed -- attach the token.
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
              handler.next(options);
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
