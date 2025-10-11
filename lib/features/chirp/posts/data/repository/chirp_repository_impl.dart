import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;

  ChirpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getFeedPosts() async {
    final postResult = await remoteDataSource.getPosts();

    return await postResult.fold(
      (failure) => left(failure),
      (posts) => right(posts.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Post>> getPostDetails({required int postId}) async {
    final result = await remoteDataSource.getPostDetails(postId: postId);
    return result.fold(
      (failure) => left(failure),
      (post) => right(post.toEntity()),
    );
  }

  @override
  Future<void> markPostAsViewed({
    required int postId,
    required String viewerId,
  }) async {
    await remoteDataSource.markPostAsViewed(postId: postId, viewerId: viewerId);
  }

  @override
  Future<Either<Failure, Post>> createPost({
    List<MultipartFile>? attachments,
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  }) async {
    final result = await remoteDataSource.createPost(
      attachments: attachments,
      title: title,
      authorId: authorId,
      communityId: communityId,
      content: content,
    );
    return result.fold(
      (failure) => left(failure),
      (created) => right(created.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Comment>>> getPostComments({
    required int postId,
  }) async {
    final result = await remoteDataSource.getPostComments(postId: postId);
    return result.fold(
      (failure) => left(failure),
      (comments) => right(comments.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Comment>> createComment({
    required int postId,
    required String authorId,
    required String content,
    int? parent,
  }) async {
    final result = await remoteDataSource.createComment(
      postId: postId,
      authorId: authorId,
      content: content,
      parent: parent,
    );
    return result.fold(
      (failure) => left(failure),
      (created) => right(created.toEntity()),
    );
  }

  // @override
  // Future<Either<Failure, List<Post>>> addFeedPosts() async {
  //   final remoteResult = await remoteDataSource.getPosts();
  //   if (remoteResult.isLeft()) {
  //     return left((remoteResult as Left).value);
  //   }

  //   final result = await localDataSource.cachePosts(
  //     (remoteResult as Right).value,
  //   );

  //   return result.fold(
  //     (failure) => left(failure),
  //     (postData) => right(postData),
  //   );
  // }

  // @override
  // Future<Either<Failure, List<PostReply>>> cachePostReplies(String postId) async {
  //   final remoteResult = await remoteDataSource.getPostReplies(postId);
  //   if (remoteResult.isLeft()) {
  //     return left((remoteResult as Left).value);
  //   }

  //   final result = await localDataSource.cachePostReplies(
  //     (remoteResult as Right).value,
  //   );

  //   return result.fold(
  //     (failure) => left(failure),
  //     (postData) => right(postData),
  //   );
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> toggleLike(String postId, bool isLiked) async {
  //   final result = await remoteDataSource.likePost(postId, isLiked);
  //   return result.fold((failure) => left(failure), (created) => right(created));
  // }
}
