import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/interactions/data/dtos/block_api_dto.dart';
import 'package:academia/features/chirp/interactions/domain/entities/block.dart';

extension BlockApiDtoMapper on BlockApiDto {
  db.Block toData() => db.Block(
    id: id,
    blockType: blockType,
    blockedUser: blockedUser,
    blockedCommunity: blockedCommunity,
    blockedName: blockedName,
    blockedImage: blockedImage,
    createdAt: createdAt,
  );

  Block toEntity() => toData().toEntity();
}

extension BlockModelHelper on db.Block {
  Block toEntity() {
    // Determine the blocked ID based on type
    String? blockedId;
    if (blockType == 'user' && blockedUser != null) {
      blockedId = blockedUser;
    } else if (blockType == 'community' && blockedCommunity != null) {
      blockedId = blockedCommunity.toString();
    }

    return Block(
      id: id,
      blockType: blockType,
      blockedId: blockedId,
      blockedName: blockedName,
      blockedImage: blockedImage,
      createdAt: createdAt,
    );
  }
}

extension BlockEntityHelper on Block {
  db.Block toData() {
    // Parse blocked ID based on type
    String? blockedUser;
    int? blockedCommunity;

    if (blockType == 'user' && blockedId != null) {
      blockedUser = blockedId;
    } else if (blockType == 'community' && blockedId != null) {
      blockedCommunity = int.tryParse(blockedId!);
    }

    return db.Block(
      id: id,
      blockType: blockType,
      blockedUser: blockedUser,
      blockedCommunity: blockedCommunity,
      blockedName: blockedName,
      blockedImage: blockedImage,
      createdAt: createdAt,
      cachedAt: DateTime.now(),
    );
  }
}
