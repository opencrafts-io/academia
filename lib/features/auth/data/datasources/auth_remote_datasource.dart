import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:logger/logger.dart';

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
  final Logger _logger = Logger();

  late final String servicePrefix;
  late final String _authBaseUrl;

  AuthRemoteDatasource({required this.flavor, required this.dioClient}) {
    if (flavor.isProduction) {
      servicePrefix = "verisafe";
      _authBaseUrl = "https://verisafe.opencrafts.io";
    } else if (flavor.isStaging) {
      servicePrefix = "qa-verisafe";
      _authBaseUrl = "https://qaverisafe.opencrafts.io";
    } else {
      servicePrefix = "dev-verisafe";
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

      _logger.d("Starting OAuth flow: $authUri");

      final callbackResult = await _launchAuthSession(authUri);
      _logger.d(callbackResult);

      final code = _extractCode(callbackResult);

      final tokenResponse = await _exchangeCode(code);

      return right(_toTokenData(tokenResponse));
    } on PlatformException catch (pe) {
      _logger.e("Auth session cancelled or failed", error: pe);
      return left(
        AuthenticationFailure(
          message: "You cancelled the authentication flow",
          error: pe,
        ),
      );
    } catch (e) {
      _logger.e("Failed to authenticate with $provider", error: e);
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TokenData>> refreshVerisafeToken(
    TokenData token,
  ) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/auth/token/refresh",
        data: {"refresh_token": token.refreshToken},
      );

      if (response.statusCode == 200) {
        final tokenResponse = _TokenExchangeResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return right(_toTokenData(tokenResponse));
      }

      throw ("Unexpected status code: ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      _logger.e("Failed to refresh token", error: e);
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: e,
        ),
      );
    }
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
      "/$servicePrefix/auth/token/exchange",
      data: {"code": code},
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
    id: 1,
    provider: "verisafe",
    accessToken: r.accessToken,
    refreshToken: r.refreshToken,
    expiresAt: r.accessExpiresAt,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
