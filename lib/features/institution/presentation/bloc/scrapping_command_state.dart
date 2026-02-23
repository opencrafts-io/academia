part of 'scrapping_command_bloc.dart';

abstract class ScrappingCommandState extends Equatable {
  final ScrappingCommand? command;

  const ScrappingCommandState({this.command});

  @override
  List<Object?> get props => [command];
}

class ScrappingCommandInitial extends ScrappingCommandState {
  const ScrappingCommandInitial() : super(command: null);
}

class ScrappingCommandLoading extends ScrappingCommandState {
  const ScrappingCommandLoading() : super(command: null);
}

class ScrappingCommandLoaded extends ScrappingCommandState {
  const ScrappingCommandLoaded({required super.command});
}

class ScrappingCommandError extends ScrappingCommandState {
  final String message;

  const ScrappingCommandError({required this.message, required super.command});

  @override
  List<Object?> get props => [message, command];
}
