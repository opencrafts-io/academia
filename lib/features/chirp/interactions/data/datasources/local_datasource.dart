
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class InteractionsLocalDataSource {
  final AppDataBase db;

  // Time-to-live for cached data (24 hours for blocks/reports)
  static const Duration ttl = Duration(hours: 24);

  InteractionsLocalDataSource({required this.db});

  
  // BLOCKS
  Future<Either<Failure, List<BlockData>>> getCachedBlocks({
    String? type,
  }) async {
    try {
      await _deleteAllExpiredCachedBlocks();

      final query = db.select(db.blockTable);

      if (type != null) {
        query.where((tbl) => tbl.blockType.equals(type));
      }

      query.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

      final blocks = await query.get();

      return right(blocks);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrieve cached blocks. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, BlockData>> createOrUpdateBlock(
    BlockData block,
  ) async {
    try {
      await _deleteAllExpiredCachedBlocks();

      final manipulated = await db
          .into(db.blockTable)
          .insertReturning(
            block.copyWith(cachedAt: Value(DateTime.now())),
            onConflict: DoUpdate(
              (old) => block.copyWith(cachedAt: Value(DateTime.now())),
              target: [db.blockTable.id],
            ),
          );

      return right(manipulated);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache block. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteBlockById(int blockId) async {
    try {
      await (db.delete(
        db.blockTable,
      )..where((tbl) => tbl.id.equals(blockId))).go();

      await _deleteAllExpiredCachedBlocks();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete cached block. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, bool>> isEntityBlocked(
    String blockType,
    String entityId,
  ) async {
    try {
      await _deleteAllExpiredCachedBlocks();

      SimpleSelectStatement<$BlockTableTable, BlockData> query;

      if (blockType == 'user') {
        query = db.select(db.blockTable)
          ..where(
            (tbl) =>
                tbl.blockType.equals(blockType) &
                tbl.blockedUser.equals(entityId),
          );
      } else {
        final communityId = int.tryParse(entityId);
        if (communityId == null) return right(false);

        query = db.select(db.blockTable)
          ..where(
            (tbl) =>
                tbl.blockType.equals(blockType) &
                tbl.blockedCommunity.equals(communityId),
          );
      }

      final result = await query.getSingleOrNull();
      return right(result != null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to check block status. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteAllCachedBlocks() async {
    try {
      await db.delete(db.blockTable).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all cached blocks. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  
  // REPORTS
  Future<Either<Failure, List<ReportData>>> getCachedReports({
    String? type,
    String? status,
  }) async {
    try {
      await _deleteAllExpiredCachedReports();

      final query = db.select(db.reportTable);

      if (type != null && status != null) {
        query.where(
          (tbl) => tbl.reportType.equals(type) & tbl.status.equals(status),
        );
      } else if (type != null) {
        query.where((tbl) => tbl.reportType.equals(type));
      } else if (status != null) {
        query.where((tbl) => tbl.status.equals(status));
      }

      query.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

      final reports = await query.get();

      return right(reports);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrieve cached reports. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, ReportData>> createOrUpdateReport(
    ReportData report,
  ) async {
    try {
      await _deleteAllExpiredCachedReports();

      final manipulated = await db
          .into(db.reportTable)
          .insertReturning(
            report.copyWith(cachedAt: Value(DateTime.now())),
            onConflict: DoUpdate(
              (old) => report.copyWith(cachedAt: Value(DateTime.now())),
              target: [db.reportTable.id],
            ),
          );

      return right(manipulated);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache report. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteAllCachedReports() async {
    try {
      await db.delete(db.reportTable).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all cached reports. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  
  // Internal Helpers - Cache Expiration
  /// Deletes all cached blocks that are older than the specified [ttl].
  Future<Either<Failure, void>> _deleteAllExpiredCachedBlocks() async {
    try {
      final expirationThreshold = DateTime.now().subtract(ttl);
      await (db.delete(db.blockTable)..where(
            (tbl) => tbl.cachedAt.isSmallerThanValue(expirationThreshold),
          ))
          .go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete expired cached blocks. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// Deletes all cached reports that are older than the specified [ttl].
  Future<Either<Failure, void>> _deleteAllExpiredCachedReports() async {
    try {
      final expirationThreshold = DateTime.now().subtract(ttl);
      await (db.delete(db.reportTable)..where(
            (tbl) => tbl.cachedAt.isSmallerThanValue(expirationThreshold),
          ))
          .go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete expired cached reports. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }
}
