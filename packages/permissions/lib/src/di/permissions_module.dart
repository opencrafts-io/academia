import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:permissions/src/application/permission_gateway.dart';
import 'package:permissions/src/application/permission_request_observer.dart';
import 'package:permissions/src/presentation/cubit/permission_cubit.dart';

import 'permissions_module.config.dart';

@InjectableInit(
  initializerName: 'initPermissions',
  preferRelativeImports: true,
  asExtension: false,
)
void configurePermissionsDependencies(
  GetIt getIt, {
  PermissionRequestObserver permissionRequestObserver =
      const NoopPermissionRequestObserver(),
}) {
  if (!getIt.isRegistered<PermissionRequestObserver>()) {
    getIt.registerSingleton<PermissionRequestObserver>(
      permissionRequestObserver,
    );
  }
  initPermissions(getIt);
  if (!getIt.isRegistered<PermissionCubit>()) {
    getIt.registerFactory(
      () => PermissionCubit(
        getIt<PermissionGateway>(),
        getIt<PermissionRequestObserver>(),
      ),
    );
  }
}
