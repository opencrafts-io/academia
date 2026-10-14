import 'package:dio/dio.dart';

import 'models/token.dart';

abstract interface class AuthHttpClient {
  Dio get dio;

  Future<TokenData> refreshTokenPair(TokenData token);
}

class AuthTokenRefreshException implements Exception {
  const AuthTokenRefreshException({
    this.statusCode,
    this.rejected = false,
    this.networkFailure = false,
  });

  final int? statusCode;
  final bool rejected;
  final bool networkFailure;

  @override
  String toString() => 'AuthTokenRefreshException';
}
