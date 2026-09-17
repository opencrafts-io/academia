import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/permission_capability.dart';
import '../../application/permission_gateway.dart';
import '../../application/permission_request_observer.dart';
import '../../application/permission_status.dart';
import 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit(this._permissionGateway, this._permissionRequestObserver)
    : super(const PermissionInitial());

  final PermissionGateway _permissionGateway;
  final PermissionRequestObserver _permissionRequestObserver;

  Future<void> request(PermissionCapability capability) async {
    final status = await _permissionGateway.request(capability);
    _permissionRequestObserver.onPermissionRequested(capability, status);
    _emitStatus(status);
  }

  Future<void> check(PermissionCapability capability) async {
    _emitStatus(await _permissionGateway.check(capability));
  }

  Future<void> checkAll(Iterable<PermissionCapability> capabilities) async {
    final statuses = await Future.wait(
      capabilities.map(_permissionGateway.check),
    );
    _emitStatus(statuses.combined);
  }

  Future<void> openSystemSettings() => _permissionGateway.openSystemSettings();

  void _emitStatus(PermissionStatus status) {
    emit(
      switch (status) {
        PermissionStatus.granted => const PermissionGranted(),
        PermissionStatus.denied => const PermissionDenied(),
        PermissionStatus.permanentlyDenied =>
          const PermissionPermanentlyDenied(),
      },
    );
  }
}
