import 'package:academia/core/core.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissionUsecase extends UseCase<PermissionStatus, AppPermission> {
  final PermissionRepository permissionRepository;
  CheckPermissionUsecase({required this.permissionRepository});

  @override
  Future<Either<Failure, PermissionStatus>> call(AppPermission params) async {
    final result = await permissionRepository.checkPermission(params);
    return right(result);
  }
}
