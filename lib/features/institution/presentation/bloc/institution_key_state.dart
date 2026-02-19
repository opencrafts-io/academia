part of 'institution_key_bloc.dart';

abstract class InstitutionKeyState extends Equatable {
  const InstitutionKeyState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class InstitutionKeyInitial extends InstitutionKeyState {
  const InstitutionKeyInitial();
}

/// State while loading the key
class InstitutionKeyLoading extends InstitutionKeyState {
  const InstitutionKeyLoading();
}

/// State when the key is successfully loaded
class InstitutionKeyLoaded extends InstitutionKeyState {
  final InstitutionKey? key;

  const InstitutionKeyLoaded({required this.key});

  @override
  List<Object?> get props => [key];
}

/// State when an error occurs
class InstitutionKeyError extends InstitutionKeyState {
  final String message;
  final InstitutionKey? key;

  const InstitutionKeyError({required this.message, this.key});

  @override
  List<Object?> get props => [message, key];
}
