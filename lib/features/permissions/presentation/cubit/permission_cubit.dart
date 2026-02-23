import 'package:academia/features/permissions/permissions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final RequestPermissionUsecase requestPermissionUsecase;
  final CheckPermissionUsecase checkPermissionUsecase;
  final Posthog posthog = Posthog();
  PermissionCubit({
    required this.requestPermissionUsecase,
    required this.checkPermissionUsecase,
  }) : super(PermissionInitial());

  Future<void> requestPermission(AppPermission permission) async {
    final result = await requestPermissionUsecase(permission);
    return result.fold(
      (error) => throw "Permission returned left this shouldn't happen",
      (status) {
        posthog.capture(
          eventName: "permission_request",
          properties: {"permission": permission.name, "status": status.name},
        );
        _emitStatus(status);
      },
    );
  }

  Future<void> checkPermission(AppPermission permission) async {
    final result = await checkPermissionUsecase(permission);
    return result.fold(
      (error) => throw "Permission returned left this shouldn't happen",
      (status) {
        _emitStatus(status);
      },
    );
  }

  /// Checks multiple permissions and emits PermissionGranted only if ALL are granted.
  Future<void> checkMultiplePermissions(List<AppPermission> permissions) async {
    PermissionStatus combinedStatus = PermissionStatus.granted;

    for (final permission in permissions) {
      final result = await checkPermissionUsecase(permission);
      result.fold(
        (error) => null,
        (status) {
          if (status.isPermanentlyDenied) {
            combinedStatus = PermissionStatus.permanentlyDenied;
          } else if (!status.isGranted &&
              combinedStatus != PermissionStatus.permanentlyDenied) {
            combinedStatus = PermissionStatus.denied;
          }
        },
      );

      if (combinedStatus.isPermanentlyDenied) break;
    }

    _emitStatus(combinedStatus);
  }

  // Helper method to avoid duplicating the if/else logic
  void _emitStatus(PermissionStatus status) {
    if (status.isGranted) {
      emit(PermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(PermissionPermanentlyDenied());
    } else {
      // Covers .isDenied, .isRestricted, .isLimited
      emit(PermissionDenied());
    }
  }
}
