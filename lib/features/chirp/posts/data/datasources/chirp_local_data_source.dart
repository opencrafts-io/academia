import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';


class ChirpLocalDataSource {
  final AppDataBase db;

  ChirpLocalDataSource({required this.db});

  Future<Either<Failure, List<Post>>> cachePosts(List<Post> posts) async {
    try {
      for (final post in posts) {
        await db.into(db.postTable).insertOnConflictUpdate(post.toData());
        for (final att in post.attachments) {
          await db
              .into(db.attachmentTable)
              .insertOnConflictUpdate(att.toData(postId: post.id));
        }
        for (final reply in post.replies) {
          await db
              .into(db.postReplyTable)
              .insertOnConflictUpdate(reply.toData(parentPostId: post.id));
        }
      }
      return right(posts);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "Failed to cache posts locally"),
      );
    }
  }

  Future<Either<Failure, List<Post>>> getCachedPosts() async {
    try {
      final postRows = await db.select(db.postTable).get();
      final List<Post> results = [];

      for (final post in postRows) {
        final attachments = await (db.select(
          db.attachmentTable,
        )..where((tbl) => tbl.postId.equals(post.id))).get();

        final replies = await (db.select(
          db.postReplyTable,
        )..where((tbl) => tbl.postId.equals(post.id))).get();

        final group = await (db.select(
          db.groupTable,
        )..where((tbl) => tbl.id.equals(post.groupId))).getSingle();

        results.add(
          post.toEntity(
            attachments: attachments,
            replies: replies,
            group: group,
          ),
        );
      }

      return right(results);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "Could not load cached posts"),
      );
    }
  }

  Future<Either<Failure, List<PostReply>>> cachePostReplies(
    List<PostReply> postReplies, 
  ) async {
    try {
      for (final reply in postReplies) {
        await db
            .into(db.postReplyTable)
            .insertOnConflictUpdate(reply.toData(parentPostId: reply.postId));
      }
      return right(postReplies);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "Failed to cache posts locally"),
      );
    }
  }

  Future<Either<Failure, List<PostReply>>> getCachedPostReplies(
    String postId,
  ) async {
    try {
      List<PostReply> results = [];

      final replies = await (db.select(
        db.postReplyTable,
      )..where((tbl) => tbl.postId.equals(postId))).get();

      results = replies.map((reply) => reply.toEntity()).toList();

      return right(results);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "Could not load cached post replies"),
      );
    }
  }
}
