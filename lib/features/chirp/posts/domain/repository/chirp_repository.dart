import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:dio/dio.dart';

abstract class ChirpRepository {
  Future<Either<Failure, List<Post>>> getFeedPosts();

  Future<Either<Failure, Post>> getPostDetails({required int postId});

  Future<Either<Failure, Post>> createPost({
    List<MultipartFile>? attachments,
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  });

  Future<void> markPostAsViewed({
    required int postId,
    required String viewerId,
  });

  // Future<Either<Failure, List<PostReply>>> getPostReplies(String postId);

  // Future<Either<Failure, List<PostReply>>> cachePostReplies(String postId);

  // Future<Either<Failure, List<Post>>> addFeedPosts();

  // Future<Either<Failure, PostReply>> addComment({
  //   required String postId,
  //   required String content,
  //   required String userName,
  //   String? parentId,
  //   required String userId,
  // });

  // Future<Either<Failure, Map<String, dynamic>>> toggleLike(
  //   String postId,
  //   bool isLiked,
  // );
}
