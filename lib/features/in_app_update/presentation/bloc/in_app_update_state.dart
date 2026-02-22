part of 'in_app_update_bloc.dart';

abstract class InAppUpdateState {}

class InAppUpdateInitial extends InAppUpdateState {}

class InAppUpdateNotRequired extends InAppUpdateState {}

class InAppUpdateRequired extends InAppUpdateState {
  final String message;
  final bool isMandatory;
  InAppUpdateRequired({required this.message, required this.isMandatory});
}
