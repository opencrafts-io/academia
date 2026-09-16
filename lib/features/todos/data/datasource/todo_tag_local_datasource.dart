import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class TodoTagLocalDatasource {
  final AppDataBase cacheDB;
  TodoTagLocalDatasource({required this.cacheDB});

  Future<Either<Failure, TodoTagItem>> createTag(TodoTagItem tag) async {
    try {
      final companion = tag.toCompanion(true).copyWith(
            localId: const Value.absent(),
          );
      final result = await cacheDB
          .into(cacheDB.todoTagItems)
          .insertReturning(companion, mode: InsertMode.insert);
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to create your tag at the moment. "
              "Clearing your phone's storage might fix this",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<TodoTagItem>>> getTags({
    bool? isDirty,
    bool? isPendingDeletion,
  }) async {
    try {
      final query = cacheDB.select(cacheDB.todoTagItems);

      query.where((t) {
        final conditions = <Expression<bool>>[];

        if (isDirty != null) {
          conditions.add(t.isDirty.equals(isDirty));
        }
        if (isPendingDeletion != null) {
          conditions.add(t.isPendingDeletion.equals(isPendingDeletion));
        }

        if (conditions.isEmpty) return const Constant(true);
        return conditions.reduce((a, b) => a & b);
      });

      query.orderBy([
        (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc),
      ]);

      final result = await query.get();
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to retrieve your tags.", error: e),
      );
    }
  }

  Future<Either<Failure, TodoTagItem?>> getTagByID(int id) async {
    try {
      final tag =
          await (cacheDB.todoTagItems.select()
                ..where((t) => t.localId.equals(id)))
              .getSingleOrNull();
      return right(tag);
    } catch (e) {
      return left(CacheFailure(message: "Failed to retrieve tag.", error: e));
    }
  }

  Future<Either<Failure, TodoTagItem?>> getTagByExternalID(String id) async {
    try {
      final tag =
          await (cacheDB.todoTagItems.select()..where((t) => t.id.equals(id)))
              .getSingleOrNull();
      return right(tag);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Something went wrong while attempting to retrieve tag",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoTagItem>> updateTag(TodoTagItem tag) async {
    try {
      final companion = tag.toCompanion(true);

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoTagItems,
      )..where((t) => t.localId.equals(tag.localId))).write(companion);

      if (rowsAffected > 0) {
        final updated = await (cacheDB.select(
          cacheDB.todoTagItems,
        )..where((t) => t.localId.equals(tag.localId))).getSingle();
        return right(updated);
      } else {
        return left(
          CacheFailure(
            message: "No tag found with ID ${tag.localId}",
            error: Exception("Update failed: 0 rows affected"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(message: "Couldn't update tag at the moment", error: e),
      );
    }
  }

  Future<Either<Failure, TodoTagItem>> softDeleteTag(TodoTagItem tag) async {
    try {
      final companion = tag
          .toCompanion(true)
          .copyWith(
            isPendingDeletion: const Value(true),
            isDirty: const Value(true),
          );

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoTagItems,
      )..where((t) => t.localId.equals(tag.localId))).write(companion);

      if (rowsAffected > 0) {
        final updated = await (cacheDB.select(
          cacheDB.todoTagItems,
        )..where((t) => t.localId.equals(tag.localId))).getSingle();
        return right(updated);
      } else {
        return left(
          CacheFailure(
            message: "Could not find tag to mark for deletion",
            error: Exception("No tag found with ID ${tag.localId}"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to set pending deletion", error: e),
      );
    }
  }

  Future<Either<Failure, Unit>> hardDeleteTag(int localId) async {
    try {
      final rowsDeleted = await (cacheDB.delete(
        cacheDB.todoTagItems,
      )..where((t) => t.localId.equals(localId))).go();

      if (rowsDeleted > 0) {
        return const Right(unit);
      } else {
        return left(
          CacheFailure(
            message: "No tag found to delete",
            error: Exception("Record with ID $localId does not exist"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(message: "Database error during hard delete", error: e),
      );
    }
  }
}
