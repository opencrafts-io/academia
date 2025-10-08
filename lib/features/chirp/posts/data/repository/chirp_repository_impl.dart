import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;

  ChirpRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Post>>> getFeedPosts() async {
    final postResult = await remoteDataSource.getPosts();

    return await postResult.fold(
      (failure) => left(failure),
      (posts) => right(posts.map((e) => e.toEntity()).toList()),
    );
  }

  // @override
  // Future<Either<Failure, List<PostReply>>> getPostReplies(String postId) async {
  //   final cacheResult = await localDataSource.getCachedPostReplies(postId);

  //   return await cacheResult.fold(
  //     (failure) => left(failure),
  //     (replies) => right(replies),
  //   );
  // }

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
  // Future<Either<Failure, Post>> createPost(
  //   String content,
  //   List<MultipartFile> attachments, {
  //   required String userName,
  //   required String email,
  //   required String groupId,
  // }) async {
  //   final result = await remoteDataSource.createPost(
  //     content,
  //     attachments,
  //     userName: userName,
  //     email: email,
  //     groupId: groupId,
  //   );
  //   return result.fold((failure) => left(failure), (created) => right(created));
  // }

  // @override
  // Future<Either<Failure, PostReply>> addComment(
  //   {required String postId, required String userId,
  //   required String content,required String userName, String? parentId}
  // ) async {
  //   final result = await remoteDataSource.addComment(postId: postId, content: content, userName: userName, parentId: parentId, userId: userId );
  //   return result.fold((failure) => left(failure), (created) => right(created));
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> toggleLike(String postId, bool isLiked) async {
  //   final result = await remoteDataSource.likePost(postId, isLiked);
  //   return result.fold((failure) => left(failure), (created) => right(created));
  // }
}
