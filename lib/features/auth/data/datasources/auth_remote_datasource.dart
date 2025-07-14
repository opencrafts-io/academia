import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:logger/logger.dart';

class AuthRemoteDatasource {
  final FlavorConfig flavorConfig;
  final Logger _logger = Logger();

  AuthRemoteDatasource({required this.flavorConfig});

  Future<Either<Failure, TokenData>> signInWithGoogle() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: "${flavorConfig.apiBaseUrl}/auth/google",
        callbackUrlScheme: "academia",
        options: FlutterWebAuth2Options(
          windowName: "Academia | Authentication",
          silentAuth: true,
          timeout: 2000,
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
