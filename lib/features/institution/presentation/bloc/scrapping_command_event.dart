part of 'scrapping_command_bloc.dart';

abstract class ScrappingCommandEvent extends Equatable {
  const ScrappingCommandEvent();

  @override
  List<Object?> get props => [];
}

class GetScrappingCommandEvent extends ScrappingCommandEvent {
  final int institutionID;

  const GetScrappingCommandEvent({required this.institutionID});

  @override
  List<Object?> get props => [institutionID];
}
