import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:logger/logger.dart';

class AuthRemoteDatasource {
  final FlavorConfig flavorConfig;
  final Logger _logger = Logger();
  final String servicePrefix;

  AuthRemoteDatasource({
    required this.flavorConfig,
    this.servicePrefix = "qa-verisafe",
  });

  // Helper to get the current host URL
  String? getHostBaseUrl() {
    if (kIsWeb) {
      final uri = Uri.base;
      return uri.origin;
    }
    return null;
  }

  Future<Either<Failure, TokenData>> signInWithGoogle() async {
    try {
      String callback;
      String platform;
      String authUrl;

      switch (flavorConfig.flavor) {
        case Flavor.staging:
          authUrl = "https://qaverisafe.opencrafts.io/auth/google";
          break;
        case Flavor.production:
          authUrl = "https://verisafe.opencrafts.io/auth/google";
          break;
        default:
          authUrl = "http://127.0.0.1:8080/auth/google";
      }

      if (kIsWeb) {
        // Redirect back to your frontend’s domain
        callback = "${getHostBaseUrl()}/auth.html";
        platform = "web";
      } else {
        // Custom scheme for mobile apps
        callback = "academia://callback";
        platform = "mobile";
      }

      _logger.d(
        "Authenticating with "
        "$authUrl"
        "?platform=$platform&redirect_uri=$callback",
      );

      final result = await FlutterWebAuth2.authenticate(
        url:
            // "https://qaverisafe.opencrafts.io/auth/google?platform=$platform&redirect=$callback",
            "$authUrl"
            "?platform=$platform&redirect_uri=$callback",
        callbackUrlScheme: "academia",
        options: FlutterWebAuth2Options(
          windowName: "Academia | Authentication",
          silentAuth: false,
          timeout: 30000, // Increased to 30 seconds for better user experience
          useWebview: false,
        ),
      );

      final token = Uri.parse(result).queryParameters['token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh_token'];

      // Log successfull login
      FirebaseAnalytics.instance.logLogin(
        loginMethod: "Google",
        parameters: {
          "platform": platform,
          "auth_url": authUrl,
          "successful": 1,
        },
      );

      return right(
        TokenData(
          id: 1,
          provider: "verisafe",
          expiresAt: DateTime.now().add(Duration(days: 1)),
          createdAt: DateTime.now(),
          accessToken: token!,
          refreshToken: refreshToken!,
          updatedAt: DateTime.now(),
        ),
      );
    } on PlatformException catch (pe) {
      _logger.e("Platform exception occurred", error: pe);
      return left(
        AuthenticationFailure(
          message: "You cancelled the authentication flow",
          error: pe,
        ),
      );
    } catch (e) {
      _logger.e("Failed to authenticate with google", error: e);
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TokenData>> signInWithSpotify() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: "https://qaverisafe.opencrafts.io/auth/google",
        callbackUrlScheme: "academia",
        options: FlutterWebAuth2Options(
          windowName: "Academia | Authentication",
          silentAuth: false,
          timeout: 30000, // Increased to 30 seconds for better user experience
          useWebview: false,
        ),
      );

      final token = Uri.parse(result).queryParameters['token'];
      return right(
        TokenData(
          id: 1,
          provider: "verisafe",
          expiresAt: DateTime.now().add(Duration(days: 1)),
          createdAt: DateTime.now(),
          accessToken: token!,
          refreshToken: "",
          updatedAt: DateTime.now(),
        ),
      );
    } on PlatformException catch (pe) {
      _logger.e("Platform exception occurred", error: pe);
      return left(
        AuthenticationFailure(
          message: "You cancelled the authentication flow",
          error: pe,
        ),
      );
    } catch (e) {
      _logger.e("Failed to authenticate with google", error: e);
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: e,
        ),
      );
    }
  }
}
