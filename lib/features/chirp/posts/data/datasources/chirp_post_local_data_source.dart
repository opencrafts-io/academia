import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ChirpPostLocalDataSource {
  final AppDataBase db;
  // A reasonable time-to-live for a cached post (6 hours)
  static const Duration ttl = Duration(hours: 6); 

  ChirpPostLocalDataSource({required this.db});

  // --------------------------------------------------------------------------
  // CRUD Operations
  // --------------------------------------------------------------------------

  /// createOrUpdatePost
  /// Attempts to cache a Chirp Post. If the post already exists (based on ID),
  /// it is updated with the new information supplied.
  Future<Either<Failure, PostData>> createOrUpdatePost(
    PostData post,
  ) async {
    try {
      await _deleteAllExpiredCachedPosts();
      
      final manipulated = await db.into(db.postTable).insertReturning(
            post.copyWith(cachedAt: Value(DateTime.now())),
            onConflict: DoUpdate(
              (old) => post.copyWith(cachedAt: Value(DateTime.now())),
              target: [db.postTable.id], 
            ),
          );

      return right(manipulated);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache post. "
          "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedPosts
  /// Returns a list of all cached posts.
  /// Internally deletes cache older than the specified [ttl] duration.
  Future<Either<Failure, List<PostData>>> getCachedPosts() async {
    try {
      await _deleteAllExpiredCachedPosts();
      final posts = await db.select(db.postTable).get();

      return right(posts);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrieve posts."
          " A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedPostByID
  /// Returns a post by its id specified by [postID].
  /// Internally deletes cache older than the specified [ttl] duration.
  Future<Either<Failure, PostData>> getCachedPostByID(
    int postID,
  ) async {
    try {
      await _deleteAllExpiredCachedPosts();
      final post = await (db.select(
        db.postTable,
      )..where((post) => post.id.equals(postID)))
          .getSingle();

      return right(post);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrieve post."

          " A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// deleteAllCachedPosts
  /// Deletes all cached posts from the local database.
  Future<Either<Failure, List<PostData>>> deleteAllCachedPosts() async {
    try {
      final deleted = await db.delete(db.postTable).goAndReturn();

      return right(deleted);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all cached posts."

          " A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// deleteCachedPost
  /// Deletes a specific cached post by its ID.
  Future<Either<Failure, void>> deleteCachedPost(
    int postID,
  ) async {
    try {
      await (db.delete(db.postTable)
                ..where((post) => post.id.equals(postID)))
              .go();

      await _deleteAllExpiredCachedPosts();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete cached post."

          " A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }
  
  // --------------------------------------------------------------------------
  // Internal Helper
  // --------------------------------------------------------------------------

  /// _deleteAllExpiredCachedPosts
  /// Deletes all cached posts that are older than the specified [ttl].
  Future<Either<Failure, void>> _deleteAllExpiredCachedPosts() async {
    try {
      final expirationThreshold = DateTime.now().subtract(ttl);
      await (db.delete(db.postTable)..where(
              (post) =>
                  post.cachedAt.isSmallerThanValue(expirationThreshold),
            ))
          .go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete expired cached posts."
          " A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }
}
