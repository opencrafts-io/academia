part of 'magnet_bloc.dart';

sealed class MagnetEvent extends Equatable {
  const MagnetEvent();
  @override
  List<Object?> get props => [];
}

class InitializeMagnet extends MagnetEvent {
  final MagnetConfig config;
  const InitializeMagnet(this.config);
}

class ExecuteScrappingCommand extends MagnetEvent {
  final InstitutionKey institutionKey;
  final ScrappingCommand command;
  final BuildContext? context; // Required for interactive commands

  const ExecuteScrappingCommand({
    required this.command,
    this.context,
    required this.institutionKey,
  });
}
