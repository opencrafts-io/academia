import 'package:academia/core/network/sensitive_request_inspector.dart';
import 'package:academia/core/network/verisafe_api_paths.dart';
import 'package:academia/core/network/verisafe_auth_interceptor.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:core/config/flavor.dart';
import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';

export 'verisafe_auth_interceptor.dart' show AuthTokenRefreshException;

class DioClient {
  DioClient(
    FlavorConfig flavor, {
    required this.authLocalDatasource,
    required this.requestInspector,
  }) : dio = Dio(
         BaseOptions(
           connectTimeout: const Duration(seconds: 30),
           receiveTimeout: const Duration(seconds: 45),
           sendTimeout: const Duration(seconds: 30),
           baseUrl: flavor.apiBaseUrl,
           preserveHeaderCase: true,
           receiveDataWhenStatusError: true,
           followRedirects: true,
           validateStatus: (status) => status != null && status < 500,
         ),
       ) {
    final apiPaths = VerisafeApiPaths(flavor);
    if (requestInspector != null) {
      dio.interceptors.add(
        SensitiveRequestInspector(requestInspector!.getDioRequestInterceptor()),
      );
    }

    _authInterceptor = VerisafeAuthInterceptor(
      dio: dio,
      authLocalDatasource: authLocalDatasource,
      apiPaths: apiPaths,
    );
    dio.interceptors.add(_authInterceptor);
  }

  final AuthLocalDatasource authLocalDatasource;
  final DioRequestInspector? requestInspector;
  final Dio dio;
  late final VerisafeAuthInterceptor _authInterceptor;

  Future<TokenData> refreshTokenPair(TokenData token) =>
      _authInterceptor.refreshTokenPair(token);
}
