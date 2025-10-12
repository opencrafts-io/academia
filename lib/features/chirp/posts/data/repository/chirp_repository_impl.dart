import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;

  ChirpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedData<Post>>> getFeedPosts({
    required int page,
    required int pageSize,
  }) async {
    final postResult = await remoteDataSource.getPosts(
      page: page,
      pageSize: pageSize,
    );

    return await postResult.fold(
      (failure) => left(failure),
      (posts) => right(
        PaginatedData(
          results: posts.results.map((e) => e.toEntity()).toList(),
          count: posts.count,
          next: posts.next,
          previous: posts.previous,
        ),
      ),
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
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  }) async {
    final result = await remoteDataSource.createPost(
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
  Future<Either<Failure, PaginatedData<Comment>>> getPostComments({
    required int postId,
    required int page,
    required int pageSize,
  }) async {
    final result = await remoteDataSource.getPostComments(
      postId: postId,
      page: page,
      pageSize: pageSize,
    );
    return result.fold(
      (failure) => left(failure),
      (comments) => right(
        PaginatedData(
          results: comments.results.map((e) => e.toEntity()).toList(),
          count: comments.count,
          next: comments.next,
          previous: comments.previous,
        ),
      ),
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

  @override
  Future<Either<Failure, Attachments>> createPostAttachment({
    required int postId,
    required MultipartFile file,
  }) async {
    final result = await remoteDataSource.createPostAttachment(
      postId: postId,
      file: file,
    );
    return result.fold(
      (failure) => left(failure),
      (attachment) => right(attachment.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    final result = await remoteDataSource.deletePost(postId: postId);
    return result.fold((failure) => left(failure), (res) => right(res));
  }

  @override
  Future<Either<Failure, Unit>> deletePostComment({
    required int commentId,
  }) async {
    final result = await remoteDataSource.deletePostComment(
      commentId: commentId,
    );
    return result.fold((failure) => left(failure), (res) => right(res));
  }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> toggleLike(String postId, bool isLiked) async {
  //   final result = await remoteDataSource.likePost(postId, isLiked);
  //   return result.fold((failure) => left(failure), (created) => right(created));
  // }
}
