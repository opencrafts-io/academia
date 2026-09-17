import 'package:equatable/equatable.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object?> get props => const [];
}

class PermissionInitial extends PermissionState {
  const PermissionInitial();
}

class PermissionGranted extends PermissionState {
  const PermissionGranted();
}

class PermissionDenied extends PermissionState {
  const PermissionDenied();
}

class PermissionPermanentlyDenied extends PermissionState {
  const PermissionPermanentlyDenied();
}
