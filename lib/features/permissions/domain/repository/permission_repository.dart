import 'package:academia/features/permissions/domain/domain.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  Future<PermissionStatus> requestPermission(AppPermission permission);
  Future<PermissionStatus> checkPermission(AppPermission permission);
}
