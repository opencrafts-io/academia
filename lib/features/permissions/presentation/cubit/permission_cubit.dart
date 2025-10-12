import 'package:academia/features/permissions/permissions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  final RequestPermissionUsecase requestPermissionUsecase;
  final CheckPermissionUsecase checkPermissionUsecase;
  PermissionCubit({
    required this.requestPermissionUsecase,
    required this.checkPermissionUsecase,
  }) : super(PermissionInitial());

  Future<void> requestPermission(AppPermission permission) async {
    final result = await requestPermissionUsecase(permission);
    return result.fold(
      (error) => throw "Permission returned left this shouldn't happen",
      (status) {
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
