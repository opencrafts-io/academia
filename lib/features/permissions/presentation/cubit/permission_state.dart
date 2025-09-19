part of 'permission_cubit.dart';

// States
abstract class PermissionState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class PermissionInitial extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionDenied extends PermissionState {}

class PermissionPermanentlyDenied extends PermissionState {}
