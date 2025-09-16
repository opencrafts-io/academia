part of 'institution_bloc.dart';

abstract class InstitutionState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class InstitutionInitialState extends InstitutionState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class InstitutionLoadingState extends InstitutionState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class InstitutionLinkedState extends InstitutionState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class InstitutionErrorState extends InstitutionState {
  final String error;
  InstitutionErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

class InstitutionLoadedState extends InstitutionState {
  final List<Institution> institutions;
  InstitutionLoadedState({required this.institutions});

  @override
  List<Object?> get props => [institutions];

  @override
  bool? get stringify => true;
}
