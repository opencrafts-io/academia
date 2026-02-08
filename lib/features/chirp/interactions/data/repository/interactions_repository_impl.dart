// lib/features/social/data/repositories/social_repository_impl.dart
import 'package:academia/features/chirp/interactions/data/datasources/local_datasource.dart';
import 'package:academia/features/chirp/interactions/data/datasources/remote_datasource.dart';
import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import '../../domain/entities/block.dart';
import '../../domain/entities/report.dart';
import '../../domain/entities/block_status.dart';
import '../models/block_model_helper.dart';
import '../models/report_model_helper.dart';

class InteractionsRepositoryImpl implements InteractionsRepository {
  final InteractionsRemoteDataSource remoteDataSource;
  final InteractionsLocalDataSource localDataSource;

  InteractionsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  // BLOCK USER
  @override
  Future<Either<Failure, Block>> blockUser(String userId) async {
    final result = await remoteDataSource.blockUser(userId);

    return result.fold((failure) => Left(failure), (blockData) async {
      await localDataSource.createOrUpdateBlock(blockData);
      return Right(blockData.toEntity());
    });
  }

  // BLOCK COMMUNITY
  @override
  Future<Either<Failure, Block>> blockCommunity(int communityId) async {
    final result = await remoteDataSource.blockCommunity(communityId);

    return result.fold((failure) => Left(failure), (blockData) async {
      await localDataSource.createOrUpdateBlock(blockData);
      return Right(blockData.toEntity());
    });
  }

  // UNBLOCK BY ID
  @override
  Future<Either<Failure, void>> unblockById(int blockId) async {
    final result = await remoteDataSource.unblockById(blockId);

    return result.fold((failure) => Left(failure), (_) async {
      await localDataSource.deleteBlockById(blockId);
      return const Right(null);
    });
  }

  // GET BLOCKS
  @override
  Future<Either<Failure, List<Block>>> getBlocks({String? type}) async {
    final result = await remoteDataSource.getBlocks(type: type);

    return result.fold(
      (failure) async {
        if (failure is NetworkFailure) {
          final cacheResult = await localDataSource.getCachedBlocks(type: type);

          return cacheResult.fold(
            (cacheFailure) => Left(failure),
            (cachedBlocks) {
              if (cachedBlocks.isNotEmpty) {
                return Right(
                  cachedBlocks.map((data) => data.toEntity()).toList(),
                );
              }
              return Left(failure);
            },
          );
        }
        return Left(failure);
      },
      (blockDataList) async {
        for (final blockData in blockDataList) {
          await localDataSource.createOrUpdateBlock(blockData);
        }
        return Right(blockDataList.map((data) => data.toEntity()).toList());
      },
    );
  }

  // CHECK BLOCK STATUS
  @override
  Future<Either<Failure, BlockStatus>> checkBlockStatus({
    required String entityType,
    required String entityId,
  }) async {
    final cacheResult = await localDataSource.isEntityBlocked(
      entityType,
      entityId,
    );

    return cacheResult.fold(
      (failure) => Left(failure),
      (isBlocked) => Right(
        BlockStatus(
          isBlocked: isBlocked,
          entityType: entityType,
          entityId: entityId,
        ),
      ),
    );
  }

  // REPORT USER
  @override
  Future<Either<Failure, Report>> reportUser({
    required String userId,
    required String reason,
  }) async {
    final result = await remoteDataSource.reportUser(
      userId: userId,
      reason: reason,
    );

    return result.fold((failure) => Left(failure), (reportData) async {
      await localDataSource.createOrUpdateReport(reportData);
      return Right(reportData.toEntity());
    });
  }

  // REPORT POST
  @override
  Future<Either<Failure, Report>> reportPost({
    required int postId,
    required String reason,
  }) async {
    final result = await remoteDataSource.reportPost(
      postId: postId,
      reason: reason,
    );

    return result.fold((failure) => Left(failure), (reportData) async {
      await localDataSource.createOrUpdateReport(reportData);
      return Right(reportData.toEntity());
    });
  }

  // REPORT COMMENT
  @override
  Future<Either<Failure, Report>> reportComment({
    required int commentId,
    required String reason,
  }) async {
    final result = await remoteDataSource.reportComment(
      commentId: commentId,
      reason: reason,
    );

    return result.fold((failure) => Left(failure), (reportData) async {
      await localDataSource.createOrUpdateReport(reportData);
      return Right(reportData.toEntity());
    });
  }

  // REPORT COMMUNITY
  @override
  Future<Either<Failure, Report>> reportCommunity({
    required int communityId,
    required String reason,
  }) async {
    final result = await remoteDataSource.reportCommunity(
      communityId: communityId,
      reason: reason,
    );

    return result.fold((failure) => Left(failure), (reportData) async {
      await localDataSource.createOrUpdateReport(reportData);
      return Right(reportData.toEntity());
    });
  }

  // GET REPORTS
  @override
  Future<Either<Failure, List<Report>>> getReports({
    String? type,
    String? status,
  }) async {
    final cacheResult = await localDataSource.getCachedReports(
      type: type,
      status: status,
    );

    return cacheResult.fold(
      (failure) => Left(failure),
      (cachedReports) =>
          Right(cachedReports.map((data) => data.toEntity()).toList()),
    );
  }
}
