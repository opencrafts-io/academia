import 'package:equatable/equatable.dart';

class BlockStatus extends Equatable {
  final bool isBlocked;
  final String entityType;
  final String entityId;

  const BlockStatus({
    required this.isBlocked,
    required this.entityType,
    required this.entityId,
  });

  @override
  List<Object?> get props => [isBlocked, entityType, entityId];
}
