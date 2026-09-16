import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class TodoTagRepository {
  /// Fetch all tags. Falls back to local cache if offline.
  Future<Either<Failure, TodoTagPage>> getTags({String? url});

  /// Local-first create. Syncs to remote in background.
  Future<Either<Failure, TodoTagEntity>> createTag(TodoTagEntity entity);

  /// Local-first update. Syncs to remote in background.
  Future<Either<Failure, TodoTagEntity>> updateTag(TodoTagEntity entity);

  /// Soft-deletes locally, hard-deletes after remote confirms.
  Future<Either<Failure, Unit>> deleteTag(int tagLocalId);

  /// Pushes all dirty/pending-deletion tags to remote.
  Future<Either<Failure, Unit>> syncTags();
}
