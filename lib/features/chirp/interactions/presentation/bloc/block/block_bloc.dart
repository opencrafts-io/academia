import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final BlockUser blockUser;
  final BlockCommunity blockCommunity;
  final UnblockById unblockById;
  final GetBlocks getBlocks;
  final CheckBlockStatus checkBlockStatus;

  BlockBloc({
    required this.blockUser,
    required this.blockCommunity,
    required this.unblockById,
    required this.getBlocks,
    required this.checkBlockStatus,
  }) : super(BlockInitial()) {
    on<BlockUserEvent>(_onBlockUser);
    on<BlockCommunityEvent>(_onBlockCommunity);
    on<UnblockByIdEvent>(_onUnblockById);
    on<GetBlocksEvent>(_onGetBlocks);
    on<CheckBlockStatusEvent>(_onCheckBlockStatus);
  }

  Future<void> _onBlockUser(
    BlockUserEvent event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockLoading());

    final result = await blockUser(event.userId);

    result.fold(
      (failure) => emit(BlockError(message: failure.message)),
      (block) =>
          emit(const BlockActionSuccess(message: 'User blocked successfully')),
    );
  }

  Future<void> _onBlockCommunity(
    BlockCommunityEvent event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockLoading());

    final result = await blockCommunity(event.communityId);

    result.fold(
      (failure) => emit(BlockError(message: failure.message)),
      (block) => emit(
        const BlockActionSuccess(message: 'Community blocked successfully'),
      ),
    );
  }

  Future<void> _onUnblockById(
    UnblockByIdEvent event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockLoading());

    final result = await unblockById(event.blockId);

    result.fold(
      (failure) => emit(BlockError(message: failure.message)),
      (_) => emit(const BlockActionSuccess(message: 'Unblocked successfully')),
    );
  }

  Future<void> _onGetBlocks(
    GetBlocksEvent event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockLoading());

    final result = await getBlocks(event.type);

    result.fold(
      (failure) => emit(BlockError(message: failure.message)),
      (blocks) => emit(BlocksLoaded(blocks: blocks)),
    );
  }

  Future<void> _onCheckBlockStatus(
    CheckBlockStatusEvent event,
    Emitter<BlockState> emit,
  ) async {
    final result = await checkBlockStatus(
      CheckBlockStatusParams(
        entityType: event.entityType,
        entityId: event.entityId,
      ),
    );

    result.fold(
      (failure) => emit(BlockError(message: failure.message)),
      (status) => emit(BlockStatusChecked(status: status)),
    );
  }
}
