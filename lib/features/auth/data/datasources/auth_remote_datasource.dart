import 'package:core/config/flavor.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

/// Represents the raw response from POST /auth/token/exchange
/// and POST /auth/token/refresh
class _TokenExchangeResponse {
  final String accessToken;
  final String refreshToken;
  final DateTime accessExpiresAt;
  final DateTime refreshExpiresAt;

  const _TokenExchangeResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.accessExpiresAt,
    required this.refreshExpiresAt,
  });

  factory _TokenExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _TokenExchangeResponse(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
        accessExpiresAt: DateTime.parse(json['access_expires_at'] as String),
        refreshExpiresAt: DateTime.parse(json['refresh_expires_at'] as String),
      );
}

class AuthRemoteDatasource with DioErrorHandler {
  final FlavorConfig flavor;
  final DioClient dioClient;
  late final VerisafeApiPaths _apiPaths;
  late final String _authBaseUrl;

  AuthRemoteDatasource({required this.flavor, required this.dioClient}) {
    _apiPaths = VerisafeApiPaths(flavor);
    if (flavor.isProduction) {
      _authBaseUrl = "https://verisafe.opencrafts.io";
    } else if (flavor.isStaging) {
      _authBaseUrl = "https://qaverisafe.opencrafts.io";
    } else {
      _authBaseUrl = "http://127.0.0.1:8080";
    }
  }

  Future<Either<Failure, TokenData>> signInWithApple() =>
      signInWithProvider("apple");

  Future<Either<Failure, TokenData>> signInWithGoogle() =>
      signInWithProvider("google");

  Future<Either<Failure, TokenData>> signInWithSpotify() =>
      signInWithProvider("spotify");

  /// Authenticates the user with the given [provider] via OAuth,
  /// then exchanges the resulting one-time code for a token pair.
  ///
  /// On mobile, opens a browser session, waits for the deep-link callback,
  /// extracts the short-lived auth [code], and immediately exchanges it
  /// via POST /auth/token/exchange before returning.
  ///
  /// [deviceToken] — FCM/APNs push token for the current device.
  /// [deviceName]  — Human-readable device label stored server-side.
  Future<Either<Failure, TokenData>> signInWithProvider(
    String provider, {
    String deviceToken = "none",
    String deviceName = "Unknown Device",
  }) async {
    try {
      final authUri = _buildAuthUri(
        provider: provider,
        deviceToken: deviceToken,
        deviceName: deviceName,
      );

      final callbackResult = await _launchAuthSession(authUri);

      final code = _extractCode(callbackResult);

      final tokenResponse = await _exchangeCode(code);

      return right(_toTokenData(tokenResponse));
    } on PlatformException catch (_) {
      return left(
        AuthenticationFailure(
          message: "You cancelled the authentication flow",
          error: Exception('OAuth authentication was cancelled or failed.'),
        ),
      );
    } catch (_) {
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: Exception('OAuth authentication failed.'),
        ),
      );
    }
  }

  /// Signs in an existing Verisafe account with its email and password.
  Future<Either<Failure, TokenData>> signInWithPassword({
    required String email,
    required String password,
    String? deviceName,
    String? deviceToken,
  }) async {
    final request = <String, dynamic>{
      'email': email.trim().toLowerCase(),
      'password': password,
    };
    if (deviceName != null && deviceName.isNotEmpty) {
      request['device_name'] = deviceName;
    }
    if (deviceToken != null && deviceToken.isNotEmpty) {
      request['device_token'] = deviceToken;
    }

    try {
      final response = await dioClient.dio.post<dynamic>(
        _apiPaths.auth('password/login'),
        data: request,
        options: Options(extra: const {'skipAuth': true, 'sensitive': true}),
      );
      if (response.statusCode == 200) {
        return right(_tokenFromResponse(response.data));
      }
      return left(_passwordResponseFailure(response, isLogin: true));
    } on DioException catch (error) {
      return left(_safeNetworkFailure(error, isLogin: true));
    } catch (_) {
      return left(
        AuthenticationFailure(
          message: 'Unable to sign in right now. Please try again.',
          error: Exception('Password sign-in failed.'),
        ),
      );
    }
  }

  /// Sets or replaces the password for the currently authenticated account.
  Future<Either<Failure, void>> setPassword(String password) async {
    try {
      final response = await dioClient.dio.put<dynamic>(
        _apiPaths.auth('password'),
        data: {'password': password},
        options: Options(extra: const {'sensitive': true}),
      );
      if (response.statusCode == 204) return right(null);
      return left(_passwordResponseFailure(response, isLogin: false));
    } on DioException catch (error) {
      return left(_safeNetworkFailure(error));
    } catch (_) {
      return left(
        ServerFailure(
          message: 'Unable to save your password. Please try again.',
          error: Exception('Password update failed.'),
        ),
      );
    }
  }

  Future<Either<Failure, TokenData>> refreshVerisafeToken(
    TokenData token,
  ) async {
    try {
      return right(await dioClient.refreshTokenPair(token));
    } on AuthTokenRefreshException catch (error) {
      if (error.rejected) {
        return left(
          AuthenticationFailure(
            message: 'Your sign-in session has expired. Please sign in again.',
            error: error,
          ),
        );
      }
      if (error.networkFailure) {
        return left(
          NetworkFailure(
            message: 'Unable to refresh your sign-in session right now.',
            error: error,
          ),
        );
      }
      return left(
        AuthenticationFailure(
          message: 'Unable to refresh your sign-in session.',
          error: error,
        ),
      );
    } catch (_) {
      return left(
        AuthenticationFailure(
          message: 'Unable to refresh your sign-in session.',
          error: Exception('Token refresh failed.'),
        ),
      );
    }
  }

  Future<Either<Failure, void>> revokeToken(TokenData token) async {
    try {
      final response = await dioClient.dio.post<dynamic>(
        _apiPaths.auth('token/revoke'),
        data: {'refresh_token': token.refreshToken},
        options: Options(extra: const {'sensitive': true}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return right(null);
      }
      return left(_passwordResponseFailure(response, isLogin: false));
    } on DioException catch (error) {
      return left(_safeNetworkFailure(error));
    } catch (_) {
      return left(
        AuthenticationFailure(
          message: 'Unable to revoke this sign-in session.',
          error: Exception('Token revocation failed.'),
        ),
      );
    }
  }

  Failure _passwordResponseFailure(
    Response<dynamic> response, {
    required bool isLogin,
  }) {
    switch (response.statusCode) {
      case 401:
        return AuthenticationFailure(
          message: isLogin
              ? 'Invalid email or password.'
              : 'Your sign-in session has expired. Please sign in again.',
          error: Exception('Authentication request was rejected.'),
        );
      case 429:
        return RateLimitFailure(
          message: 'Too many sign-in attempts. Please wait and try again.',
          error: Exception('Authentication rate limit reached.'),
        );
      case 503:
        return ServerFailure(
          message:
              'Sign-in is temporarily unavailable. Please try again shortly.',
          error: Exception('Authentication rate limiter is unavailable.'),
        );
      case 400:
        return ValidationFailure(
          message: _errorMessage(
            response.data,
            'Please check the password and try again.',
          ),
          error: Exception('Authentication request was rejected.'),
        );
      default:
        final status = response.statusCode;
        return ServerFailure(
          message: status == null
              ? 'Authentication response did not include an HTTP status.'
              : 'Authentication service returned an unexpected response '
                    '(HTTP $status).',
          error: Exception('Unexpected authentication status.'),
        );
    }
  }

  Failure _safeNetworkFailure(DioException error, {bool isLogin = false}) {
    if (isLogin && error.response?.statusCode == 503) {
      return ServerFailure(
        message:
            'Sign-in is temporarily unavailable. Please try again shortly.',
        error: Exception('Authentication rate limiter is unavailable.'),
      );
    }
    final isConnectivityFailure = switch (error.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => true,
      _ => false,
    };
    if (isConnectivityFailure) {
      return NetworkFailure(
        message: 'Check your connection and try again.',
        error: Exception('Authentication network request failed.'),
      );
    }
    final statusCode = error.response?.statusCode;
    return ServerFailure(
      message: statusCode == null
          ? 'Authentication request failed before receiving a response '
                '(${error.type.name}).'
          : 'Authentication service returned an unexpected response '
                '(HTTP $statusCode).',
      error: Exception('Authentication server request failed.'),
    );
  }

  String _errorMessage(Object? data, String fallback) {
    if (data is Map && data['error'] is String) {
      final message = (data['error'] as String).trim();
      if (message.isNotEmpty) return message;
    }
    return fallback;
  }

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

  /// Builds the backend OAuth initiation URL with all required query params.
  Uri _buildAuthUri({
    required String provider,
    required String deviceToken,
    required String deviceName,
  }) {
    final callback = kIsWeb
        ? "${Uri.base.origin}/auth.html"
        : "https://academia.opencrafts.io/auth/callback";

    final platform = kIsWeb ? "web" : "mobile";

    return Uri.parse("$_authBaseUrl/auth/$provider").replace(
      queryParameters: {
        "platform": platform,
        "redirect_uri": callback,
        "deep_link": callback,
        "device_name": deviceName,
        "device_token": deviceToken,
      },
    );
  }

  /// Opens the browser auth session and returns the raw callback URL string.
  Future<String> _launchAuthSession(Uri authUri) =>
      FlutterWebAuth2.authenticate(
        url: authUri.toString(),
        callbackUrlScheme: "https",
        options: const FlutterWebAuth2Options(
          windowName: "Academia | Authentication",
          silentAuth: false,
          timeout: 30000,
          useWebview: false,
          httpsHost: "academia.opencrafts.io",
          httpsPath: "/auth/callback",
        ),
      );

  /// Extracts the one-time auth [code] from the deep-link callback URL.
  ///
  /// Throws [AuthenticationFailure] if the code is missing — this indicates
  /// a backend misconfiguration rather than a user-facing error.
  String _extractCode(String callbackUrl) {
    final code = Uri.parse(callbackUrl).queryParameters['code'];
    if (code == null || code.isEmpty) {
      throw AuthenticationFailure(
        message: "Auth callback is missing the code parameter",
        error: Exception("Missing 'code' in callback: $callbackUrl"),
      );
    }
    return code;
  }

  /// Exchanges the one-time [code] for a token pair via the backend.
  /// The code is deleted server-side on first use (60s TTL).
  Future<_TokenExchangeResponse> _exchangeCode(String code) async {
    final response = await dioClient.dio.post(
      _apiPaths.auth('token/exchange'),
      data: {"code": code},
      options: Options(extra: const {'skipAuth': true, 'sensitive': true}),
    );

    if (response.statusCode != 200) {
      throw AuthenticationFailure(
        message: "Code exchange failed (${response.statusCode})",
        error: Exception(response.data),
      );
    }

    return _TokenExchangeResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  /// Maps a [_TokenExchangeResponse] to the domain [TokenData] model.
  TokenData _toTokenData(_TokenExchangeResponse r) => TokenData(
    provider: "verisafe",
    accessToken: r.accessToken,
    refreshToken: r.refreshToken,
    accessExpiresAt: r.accessExpiresAt,
    refreshExpiresAt: r.refreshExpiresAt,
  );
}
