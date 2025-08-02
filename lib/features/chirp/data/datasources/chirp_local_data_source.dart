import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/post.dart';

class ChirpLocalDataSource {
  final AppDataBase db;

  ChirpLocalDataSource({required this.db});

  Future<Either<Failure, List<PostEntity>>> cachePosts(
    List<Post> posts,
  ) async {
    try {
      for (final post in posts) {
        await db.into(db.postTable).insertOnConflictUpdate(post.toData());
        for (final att in post.attachments) {
          await db.into(db.attachmentTable).insert(att.toData(postId: post.id));
        }
        for (final reply in post.replies) {
          await db
              .into(db.postReplyTable)
              .insert(reply.toData(parentPostId: post.id));
        }
      }
      return right(posts.map((post) => post.toData()).toList());
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

        results.add(post.toEntity(attachments: attachments, replies: replies));
      }

      return right(results);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "Could not load cached posts"),
      );
    }
  }

}
