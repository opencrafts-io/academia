import 'package:academia/core/core.dart';
import 'package:academia/features/auth/domain/entities/token.dart';
import 'package:academia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class SignInWithPasswordUsecase {
  const SignInWithPasswordUsecase({required this.repository});

  final AuthRepository repository;

  Future<Either<Failure, Token>> call({
    required String email,
    required String password,
  }) async {
    return repository.signInWithPassword(
      email: email.trim().toLowerCase(),
      password: password,
      deviceName: await _deviceName(),
    );
  }

  Future<String?> _deviceName() async {
    if (kIsWeb) return null;
    final deviceInfo = DeviceInfoPlugin();
    try {
      return switch (defaultTargetPlatform) {
        TargetPlatform.android => (await deviceInfo.androidInfo).model,
        TargetPlatform.iOS => (await deviceInfo.iosInfo).name,
        TargetPlatform.macOS => (await deviceInfo.macOsInfo).computerName,
        TargetPlatform.windows => (await deviceInfo.windowsInfo).computerName,
        TargetPlatform.linux => (await deviceInfo.linuxInfo).prettyName,
        TargetPlatform.fuchsia => null,
      };
    } catch (_) {
      return null;
    }
  }
}
