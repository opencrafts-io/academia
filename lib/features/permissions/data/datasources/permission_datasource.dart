import 'package:permission_handler/permission_handler.dart';

abstract class PermissionDatasource {
  Future<PermissionStatus> requestPermission(Permission permission);
  Future<PermissionStatus> checkPermission(Permission permission);
}

class PermissionDatasourceImpl implements PermissionDatasource {
  @override
  Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status;
  }

  @override
  Future<PermissionStatus> checkPermission(Permission permission) async {
    return await permission.status;
  }
}
