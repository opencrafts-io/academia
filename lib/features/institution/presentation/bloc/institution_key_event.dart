part of 'institution_key_bloc.dart';

abstract class InstitutionKeyEvent extends Equatable {
  const InstitutionKeyEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch the key for a specific institution
class GetInstitutionKeyEvent extends InstitutionKeyEvent {
  final int institutionID;

  const GetInstitutionKeyEvent({required this.institutionID});

  @override
  List<Object?> get props => [institutionID];
}

/// Event to save an institution key
class SaveInstitutionKeyEvent extends InstitutionKeyEvent {
  final InstitutionKey key;

  const SaveInstitutionKeyEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

