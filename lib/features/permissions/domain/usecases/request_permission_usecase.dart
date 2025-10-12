import 'package:academia/core/core.dart';
import 'package:academia/features/permissions/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionUsecase
    extends UseCase<PermissionStatus, AppPermission> {
  final PermissionRepository permissionRepository;
  RequestPermissionUsecase({required this.permissionRepository});
  @override
  Future<Either<Failure, PermissionStatus>> call(AppPermission params) async {
    final result = await permissionRepository.requestPermission(params);
    return right(result);
  }
}
