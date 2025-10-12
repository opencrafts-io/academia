import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:logger/logger.dart';

class AuthRemoteDatasource with DioErrorHandler {
  final FlavorConfig flavor;
  final Logger _logger = Logger();
  late String servicePrefix;
  final DioClient dioClient;

  AuthRemoteDatasource({required this.flavor, required this.dioClient}) {
    if (flavor.isProduction) {
      servicePrefix = "verisafe";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-verisafe';
    } else {
      servicePrefix = "dev-verisafe";
    }
  }

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

      switch (flavor.flavor) {
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
          expiresAt: DateTime.now().add(Duration(days: 7)),
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
      String callback;
      String platform;
      String authUrl;

      switch (flavor.flavor) {
        case Flavor.staging:
          authUrl = "https://qaverisafe.opencrafts.io/auth/spotify";
          break;
        case Flavor.production:
          authUrl = "https://verisafe.opencrafts.io/auth/spotify";
          break;
        default:
          authUrl = "http://127.0.0.1:8080/auth/spotify";
      }

      if (kIsWeb) {
        callback = "${getHostBaseUrl()}/auth.html";
        platform = "web";
      } else {
        callback = "academia://callback";
        platform = "mobile";
      }

      final result = await FlutterWebAuth2.authenticate(
        url: "$authUrl?platform=$platform&redirect_uri=$callback",
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
      return right(
        TokenData(
          id: 1,
          provider: "verisafe",
          expiresAt: DateTime.now().add(Duration(days: 7)),
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
      _logger.e("Failed to authenticate with spotify", error: e);
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
        data: token.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(
          TokenData(
            id: 1,
            accessToken: response.data["access_token"],
            refreshToken: response.data["refresh_token"],
            provider: "verisafe",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      }
      throw ("Wrong status code recieved from server");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      _logger.e("Failed to refresh verisafe token", error: e);
      return left(
        AuthenticationFailure(
          message: "Something went wrong while trying to authenticate you",
          error: e,
        ),
      );
    }
  }
}
