import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:dio/dio.dart';

abstract class ChirpRepository {
  Future<Either<Failure, List<Post>>> getFeedPosts();

  Future<Either<Failure, Post>> getPostDetails({required int postId});

  Future<Either<Failure, Post>> createPost({
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  });

  Future<void> markPostAsViewed({
    required int postId,
    required String viewerId,
  });

  Future<Either<Failure, Attachments>> createPostAttachment({
    required int postId,
    required MultipartFile file,
  });

  Future<Either<Failure, PaginatedData<Comment>>> getPostComments({
    required int postId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Comment>> createComment({
    required int postId,
    required String authorId,
    required String content,
    int? parent,
  });

  Future<Either<Failure, Unit>> deletePost({required int postId});

  Future<Either<Failure, Unit>> deletePostComment({required int commentId});

  // Future<Either<Failure, List<PostReply>>> cachePostReplies(String postId);

  // Future<Either<Failure, List<Post>>> addFeedPosts();

  // Future<Either<Failure, Map<String, dynamic>>> toggleLike(
  //   String postId,
  //   bool isLiked,
  // );
}
