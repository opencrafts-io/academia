import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as platform;

import 'permission_capability.dart';
import 'permission_status.dart';

abstract interface class PermissionGateway {
  Future<PermissionStatus> check(PermissionCapability capability);

  Future<PermissionStatus> request(PermissionCapability capability);

  Future<void> openSystemSettings();
}

@LazySingleton(as: PermissionGateway)
class PermissionHandlerGateway implements PermissionGateway {
  const PermissionHandlerGateway();

  @override
  Future<PermissionStatus> check(PermissionCapability capability) async {
    return _statusFromPlatform((await _platformPermission(capability).status));
  }

  @override
  Future<void> openSystemSettings() async {
    await platform.openAppSettings();
  }

  @override
  Future<PermissionStatus> request(PermissionCapability capability) async {
    return _statusFromPlatform(
      await _platformPermission(capability).request(),
    );
  }

  platform.Permission _platformPermission(PermissionCapability capability) {
    return switch (capability) {
      PermissionCapability.location => platform.Permission.location,
      PermissionCapability.notifications => platform.Permission.notification,
      PermissionCapability.camera => platform.Permission.camera,
      PermissionCapability.storage => platform.Permission.storage,
      PermissionCapability.preciseAlarms =>
        platform.Permission.scheduleExactAlarm,
    };
  }

  PermissionStatus _statusFromPlatform(platform.PermissionStatus status) {
    if (status.isGranted) return PermissionStatus.granted;
    if (status.isPermanentlyDenied) return PermissionStatus.permanentlyDenied;
    return PermissionStatus.denied;
  }
}
