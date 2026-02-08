part of 'block_bloc.dart';

abstract class BlockEvent extends Equatable {
  const BlockEvent();

  @override
  List<Object?> get props => [];
}

class BlockUserEvent extends BlockEvent {
  final String userId;

  const BlockUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class BlockCommunityEvent extends BlockEvent {
  final int communityId;

  const BlockCommunityEvent({required this.communityId});

  @override
  List<Object?> get props => [communityId];
}

class UnblockByIdEvent extends BlockEvent {
  final int blockId;

  const UnblockByIdEvent({required this.blockId});

  @override
  List<Object?> get props => [blockId];
}

class GetBlocksEvent extends BlockEvent {
  final String? type;

  const GetBlocksEvent({this.type});

  @override
  List<Object?> get props => [type];
}

class CheckBlockStatusEvent extends BlockEvent {
  final String entityType;
  final String entityId;

  const CheckBlockStatusEvent({
    required this.entityType,
    required this.entityId,
  });

  @override
  List<Object?> get props => [entityType, entityId];
}
