import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import '../entities/block.dart';
import '../entities/report.dart';
import '../entities/block_status.dart';

abstract class InteractionsRepository {
  /// Block a user
  Future<Either<Failure, Block>> blockUser(String userId);

  /// Block a community
  Future<Either<Failure, Block>> blockCommunity(int communityId);

  /// Unblock by block ID
  Future<Either<Failure, void>> unblockById(int blockId);

  /// Get list of all blocks
  Future<Either<Failure, List<Block>>> getBlocks({String? type});

  /// Check if an entity is blocked
  Future<Either<Failure, BlockStatus>> checkBlockStatus({
    required String entityType,
    required String entityId,
  });

  /// Report a user
  Future<Either<Failure, Report>> reportUser({
    required String userId,
    required String reason,
  });

  /// Report a post
  Future<Either<Failure, Report>> reportPost({
    required int postId,
    required String reason,
  });

  /// Report a comment
  Future<Either<Failure, Report>> reportComment({
    required int commentId,
    required String reason,
  });

  /// Report a community
  Future<Either<Failure, Report>> reportCommunity({
    required int communityId,
    required String reason,
  });

  /// Get list of all reports
  Future<Either<Failure, List<Report>>> getReports({
    String? type,
    String? status,
  });
}
