import 'dart:io' show Platform;

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

enum AuthProvider { spotify, google, apple }

@injectable
class SignInWithProviderUsecase extends UseCase<Token, AuthProvider> {
  final AuthRepository repository;

  SignInWithProviderUsecase({required this.repository});

  @override
  Future<Either<Failure, Token>> call(AuthProvider provider) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String deviceToken = "none";
    String deviceName = "Unknown device";

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo info = await deviceInfo.androidInfo;
        deviceName = info.model;
        deviceToken = info.id;
      } else if (Platform.isIOS) {
        final IosDeviceInfo info = await deviceInfo.iosInfo;
        deviceName = info.name;
        deviceToken = info.identifierForVendor ?? "none";
      } else if (Platform.isMacOS) {
        final MacOsDeviceInfo info = await deviceInfo.macOsInfo;
        deviceName = info.computerName;
        deviceToken = info.systemGUID ?? "none";
      } else if (Platform.isWindows) {
        final WindowsDeviceInfo info = await deviceInfo.windowsInfo;
        deviceName = info.computerName;
        deviceToken = info.deviceId;
      } else if (Platform.isLinux) {
        final LinuxDeviceInfo info = await deviceInfo.linuxInfo;
        deviceName = info.prettyName;
        deviceToken = info.machineId ?? "none";
      }
    } catch (e) {
      return left(Failure.auth(message: 'Failed to authentiacate', error: e));
    }

    return await repository.signInWithProvider(
      provider.name,
      deviceName: deviceName,
      deviceToken: deviceToken,
    );
  }
}
