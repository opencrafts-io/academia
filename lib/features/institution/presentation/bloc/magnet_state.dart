part of 'magnet_bloc.dart';

sealed class MagnetState extends Equatable {
  const MagnetState();
  @override
  List<Object?> get props => [];
}

class MagnetInitial extends MagnetState {}

class MagnetInitializing extends MagnetState {}

class MagnetReady extends MagnetState {
  final Magnet magnet;
  const MagnetReady(this.magnet);
}

class MagnetProcessing extends MagnetState {
  final ScrappingCommand command;
  final InstructionProgressEvent? progress;
  const MagnetProcessing({required this.command, this.progress});
}

class MagnetSuccess extends MagnetState {
  final ScrappingResult result;
  const MagnetSuccess(this.result);
}

class MagnetError extends MagnetState {
  final String message;
  const MagnetError(this.message);
}
