import 'package:academia/features/permissions/data/data.dart';
import 'package:academia/features/permissions/domain/domain.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionDatasource permissionDatasource;
  PermissionRepositoryImpl({required this.permissionDatasource});

  ph.Permission _mapToPlatformPermission(AppPermission permission) {
    switch (permission) {
      case AppPermission.location:
        return ph.Permission.location;
      case AppPermission.notification:
        return ph.Permission.notification;
      case AppPermission.camera:
        return ph.Permission.camera;
      case AppPermission.storage:
        return ph.Permission.storage;
    }
  }

  @override
  Future<ph.PermissionStatus> requestPermission(AppPermission permission) {
    final platformPermission = _mapToPlatformPermission(permission);
    return permissionDatasource.requestPermission(platformPermission);
  }

  @override
  Future<ph.PermissionStatus> checkPermission(AppPermission permission) {
    final platformPermission = _mapToPlatformPermission(permission);
    return permissionDatasource.checkPermission(platformPermission);
  }
}
