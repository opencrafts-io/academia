import 'package:academia/features/chirp/interactions/domain/entities/block_status.dart';

class BlockStatusModel extends BlockStatus {
  const BlockStatusModel({
    required super.isBlocked,
    required super.entityType,
    required super.entityId,
  });

  factory BlockStatusModel.fromJson(Map<String, dynamic> json) {
    return BlockStatusModel(
      isBlocked: json['is_blocked'] as bool,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_blocked': isBlocked,
      'entity_type': entityType,
      'entity_id': entityId,
    };
  }

  BlockStatus toEntity() {
    return BlockStatus(
      isBlocked: isBlocked,
      entityType: entityType,
      entityId: entityId,
    );
  }
}
