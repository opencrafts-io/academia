import 'package:academia/core/network/verisafe_api_paths.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:dio/dio.dart';

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

class VerisafeAuthInterceptor extends Interceptor {
  VerisafeAuthInterceptor({
    required Dio dio,
    required AuthLocalDatasource authLocalDatasource,
    required VerisafeApiPaths apiPaths,
  }) : _dio = dio,
       _authLocalDatasource = authLocalDatasource,
       _apiPaths = apiPaths;

  final Dio _dio;
  final AuthLocalDatasource _authLocalDatasource;
  final VerisafeApiPaths _apiPaths;
  Future<TokenData>? _refreshInFlight;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await _authorize(options);
      handler.next(options);
    } catch (_) {
      handler.reject(_refreshFailure(options));
    }
  }

  Future<void> _authorize(RequestOptions options) async {
    if (options.extra['skipAuth'] == true) return;

    final token = await _storedToken();
    if (token == null) return;

    final requestToken = await _usableAccessToken(options, token);
    options.extra['sensitive'] = true;
    options.headers['Authorization'] = 'Bearer ${requestToken.accessToken}';
  }

  Future<TokenData> _usableAccessToken(
    RequestOptions options,
    TokenData token,
  ) async {
    if (token.accessExpiresAt.isAfter(DateTime.now())) return token;

    options.extra['authRefreshAttempted'] = true;
    try {
      final refreshed = await refreshTokenPair(token);
      _updateRevocationRefreshToken(options, refreshed);
      return refreshed;
    } on AuthTokenRefreshException catch (error) {
      if (!error.networkFailure) rethrow;
      return token;
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final options = response.requestOptions;
    if (!_shouldRefresh(response)) {
      _redactAuthorization(options);
      handler.next(response);
      return;
    }

    try {
      final token = await _storedToken();
      if (token == null) {
        _redactAuthorization(options);
        handler.next(response);
        return;
      }

      final retryResponse = await _retryUnauthorized(response, token);
      handler.resolve(retryResponse);
    } catch (_) {
      _redactAuthorization(options);
      handler.reject(_refreshFailure(options));
    }
  }

  bool _shouldRefresh(Response<dynamic> response) {
    final options = response.requestOptions;
    return response.statusCode == 401 &&
        options.extra['skipAuth'] != true &&
        options.extra['authRetried'] != true &&
        options.extra['authRefreshAttempted'] != true;
  }

  Future<Response<dynamic>> _retryUnauthorized(
    Response<dynamic> response,
    TokenData currentToken,
  ) async {
    final options = response.requestOptions;
    final rejectedAccessToken = _bearerToken(options.headers['Authorization']);
    options.extra['authRefreshAttempted'] = true;

    final retryToken = currentToken.accessToken != rejectedAccessToken
        ? currentToken
        : await refreshTokenPair(currentToken);

    options.extra['authRetried'] = true;
    options.extra['sensitive'] = true;
    options.headers['Authorization'] = 'Bearer ${retryToken.accessToken}';
    _updateRevocationRefreshToken(options, retryToken);

    // Dio finalizes multipart bodies while sending them. The original body
    // cannot be sent a second time after a 401 response.
    if (options.data is FormData) {
      options.data = (options.data! as FormData).clone();
    }

    return _dio.fetch<dynamic>(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _redactAuthorization(err.requestOptions);
    final responseOptions = err.response?.requestOptions;
    if (responseOptions != null) _redactAuthorization(responseOptions);
    handler.next(err);
  }

  Future<TokenData?> _storedToken() async {
    final result = await _authLocalDatasource.getTokenByProvider('verisafe');
    TokenData? token;
    result.fold((_) {}, (value) => token = value);
    return token;
  }

  Future<TokenData> refreshTokenPair(TokenData observedToken) {
    final inFlight = _refreshInFlight;
    if (inFlight != null) return inFlight;

    final refresh = _refreshTokenPair(observedToken);
    _refreshInFlight = refresh;
    return refresh.whenComplete(() {
      if (identical(_refreshInFlight, refresh)) _refreshInFlight = null;
    });
  }

  Future<TokenData> _refreshTokenPair(TokenData observedToken) async {
    final currentToken = await _currentTokenForRefresh(observedToken);
    if (currentToken != null) return currentToken;

    try {
      final response = await _requestTokenRotation(observedToken);
      final rotatedToken = _tokenFromResponse(response.data);
      await _saveRotatedToken(rotatedToken);
      return rotatedToken;
    } on AuthTokenRefreshException {
      rethrow;
    } catch (_) {
      // A malformed successful response may already have rotated the token.
      await _invalidateSession();
      throw const AuthTokenRefreshException(rejected: true);
    }
  }

  /// Returns a newer pair when another request has already rotated it.
  Future<TokenData?> _currentTokenForRefresh(TokenData observedToken) async {
    final currentToken = await _storedToken();
    if (currentToken == null) {
      await _invalidateSession();
      throw const AuthTokenRefreshException(rejected: true);
    }

    final pairChanged =
        currentToken.accessToken != observedToken.accessToken ||
        currentToken.refreshToken != observedToken.refreshToken;
    if (pairChanged) return currentToken;

    if (!currentToken.refreshExpiresAt.isAfter(DateTime.now())) {
      await _invalidateSession();
      throw const AuthTokenRefreshException(rejected: true, statusCode: 401);
    }

    return null;
  }

  Future<Response<dynamic>> _requestTokenRotation(TokenData token) async {
    try {
      final response = await _dio.post<dynamic>(
        _apiPaths.auth('token/refresh'),
        data: {'refresh_token': token.refreshToken},
        options: Options(extra: const {'skipAuth': true, 'sensitive': true}),
      );

      if (response.statusCode == 400 || response.statusCode == 401) {
        await _invalidateSession();
        throw AuthTokenRefreshException(
          statusCode: response.statusCode,
          rejected: true,
        );
      }
      if (response.statusCode != 200) {
        throw AuthTokenRefreshException(
          statusCode: response.statusCode,
          networkFailure: true,
        );
      }
      return response;
    } on AuthTokenRefreshException {
      rethrow;
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 400 || statusCode == 401) {
        await _invalidateSession();
        throw AuthTokenRefreshException(statusCode: statusCode, rejected: true);
      }
      throw AuthTokenRefreshException(
        statusCode: statusCode,
        networkFailure: true,
      );
    } catch (_) {
      await _invalidateSession();
      throw const AuthTokenRefreshException(rejected: true);
    }
  }

  Future<void> _saveRotatedToken(TokenData token) async {
    final result = await _authLocalDatasource.cacheOrUpdateToken(token);
    var saved = false;
    result.fold((_) {}, (_) => saved = true);
    if (saved) return;

    // The server has rotated the refresh token. Discard the unusable old pair.
    await _invalidateSession();
    throw const AuthTokenRefreshException(rejected: true);
  }

  Future<void> _invalidateSession() =>
      _authLocalDatasource.invalidateVerisafeSession();

  TokenData _tokenFromResponse(Object? data) {
    if (data is! Map) {
      throw const FormatException('Invalid token response.');
    }
    final json = data.cast<String, dynamic>();
    return TokenData(
      provider: 'verisafe',
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      accessExpiresAt: DateTime.parse(json['access_expires_at'] as String),
      refreshExpiresAt: DateTime.parse(json['refresh_expires_at'] as String),
    );
  }

  String? _bearerToken(Object? authorization) {
    if (authorization is! String || !authorization.startsWith('Bearer ')) {
      return null;
    }
    return authorization.substring('Bearer '.length);
  }

  void _updateRevocationRefreshToken(RequestOptions options, TokenData token) {
    if (options.uri.path != _apiPaths.auth('token/revoke') ||
        options.data is! Map) {
      return;
    }
    options.data = Map<String, dynamic>.from(options.data as Map)
      ..['refresh_token'] = token.refreshToken;
  }

  void _redactAuthorization(RequestOptions options) {
    options.headers.removeWhere(
      (name, _) => name.toLowerCase() == 'authorization',
    );
  }

  DioException _refreshFailure(RequestOptions options) => DioException(
    requestOptions: RequestOptions(
      path: options.path,
      baseUrl: options.baseUrl,
      method: options.method,
    ),
    type: DioExceptionType.unknown,
    message:
        'Your sign-in session could not be refreshed. Please sign in again.',
  );
}
