part of 'block_bloc.dart';

abstract class BlockState extends Equatable {
  const BlockState();

  @override
  List<Object?> get props => [];
}

class BlockInitial extends BlockState {}

class BlockLoading extends BlockState {}

class BlockActionSuccess extends BlockState {
  final String message;

  const BlockActionSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class BlocksLoaded extends BlockState {
  final List<Block> blocks;

  const BlocksLoaded({required this.blocks});

  @override
  List<Object?> get props => [blocks];
}

class BlockStatusChecked extends BlockState {
  final BlockStatus status;

  const BlockStatusChecked({required this.status});

  @override
  List<Object?> get props => [status];
}

class BlockError extends BlockState {
  final String message;

  const BlockError({required this.message});

  @override
  List<Object?> get props => [message];
}
