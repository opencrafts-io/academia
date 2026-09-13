import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;
  final ChirpPostLocalDataSource localDataSource;
  final PollRemoteDataSource pollRemoteDataSource;

  ChirpRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.pollRemoteDataSource,
  });

  /// While polls are mocked, feed posts get demo polls attached here so the
  /// UI is exercisable. A no-op once the real datasource is wired in DI.
  PostData _decoratePoll(PostData post) {
    final ds = pollRemoteDataSource;
    return ds is MockPollRemoteDataSource ? ds.decorate(post) : post;
  }

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
      (failure) async {
        final posts = await localDataSource.getCachedPosts();

        return posts.fold(
          (failure) {
            return left(failure);
          },
          (retrieved) {
            return right(
              PaginatedData(
                results: retrieved.map((e) => e.toEntity()).toList(),
                count: retrieved.length,
                next: null,
                previous: null,
              ),
            );
          },
        );
      },
      (posts) async {
        final postEntities = <Post>[];
        for (final raw in posts.results) {
          final post = _decoratePoll(raw);
          await localDataSource.createOrUpdatePost(post);
          postEntities.add(post.toEntity());
        }
        return right(
          PaginatedData(
            results: postEntities,
            count: posts.count,
            next: posts.next,
            previous: posts.previous,
          ),
        );
      },
    );
  }

  @override
  /// First look through the cache then try the remote repo
  Future<Either<Failure, Post>> getPostDetails({required int postId}) async {
    final localRes = await localDataSource.getCachedPostByID(postId);

    return localRes.fold((failure) async {
      final result = await remoteDataSource.getPostDetails(postId: postId);
      return result.fold((failure) => left(failure), (raw) async {
        final post = _decoratePoll(raw);
        await localDataSource.createOrUpdatePost(post);
        return right(post.toEntity());
      });
    }, (post) => right(post.toEntity()));
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
    PollDraft? poll,
  }) async {
    final result = await remoteDataSource.createPost(
      title: title,
      authorId: authorId,
      communityId: communityId,
      content: content,
      poll: poll,
    );
    return result.fold((failure) => left(failure), (raw) async {
      var created = raw;
      // The mock backend can't create polls server-side, so mint one here.
      final ds = pollRemoteDataSource;
      if (poll != null && ds is MockPollRemoteDataSource) {
        created = ds.attachDraft(raw, poll);
      }
      await localDataSource.createOrUpdatePost(created);
      return right(created.toEntity());
    });
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
    return result.fold((failure) => left(failure), (res) async {
      await localDataSource.deleteCachedPost(postId);
      return right(res);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePostComment({
    required int commentId,
  }) async {
    final result = await remoteDataSource.deletePostComment(
      commentId: commentId,
    );
    return result.fold((failure) => left(failure), (res) async {
      return right(res);
    });
  }

  @override
  Future<Either<Failure, PaginatedData<Post>>> getPostsFromCommunity({
    required int communityId,
    required int page,
    required int pageSize,
  }) async {
    final result = await remoteDataSource.getPostsFromCommunity(
      communityId: communityId,
      page: page,
      pageSize: pageSize,
    );
    return result.fold(
      (failure) => left(failure),
      (posts) => right(
        PaginatedData(
          results: posts.results
              .map((e) => _decoratePoll(e).toEntity())
              .toList(),
          count: posts.count,
          next: posts.next,
          previous: posts.previous,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Post>> toggleLike({
    required Post post,
    required bool isCurrentlyLiked,
    required String voterId,
  }) async {
    final result = await remoteDataSource.toggleLike(
      postId: post.id,
      isCurrentlyLiked: isCurrentlyLiked,
      voterId: voterId,
    );
    return result.fold((failure) => left(failure), (data) {
      final updatedPost = post.copyWith(
        upvotes:
            (data['upvotes'] as int?) ??
            (isCurrentlyLiked
                ? (post.upvotes - 1).clamp(0, double.maxFinite.toInt())
                : post.upvotes + 1),
        isLikedByMe: data['is_liked'] as bool? ?? !isCurrentlyLiked,
      );
      // Best-effort local cache update
      localDataSource.createOrUpdatePost(updatedPost.toData());
      return right(updatedPost);
    });
  }

  Future<Either<Failure, Post>> _applyPollResult(
    Post post,
    Either<Failure, PollData> result,
  ) async {
    return result.fold((failure) => left(failure), (pollData) async {
      final updatedPost = post.copyWith(poll: pollData.toEntity());
      // Best-effort local cache update
      await localDataSource.createOrUpdatePost(updatedPost.toData());
      return right(updatedPost);
    });
  }

  @override
  Future<Either<Failure, Post>> voteOnPoll({
    required Post post,
    required List<int> optionIds,
    required String voterId,
  }) async {
    final poll = post.poll;
    if (poll == null) {
      return left(NetworkFailure(message: 'Post has no poll', error: 'poll'));
    }
    final result = await pollRemoteDataSource.vote(
      pollId: poll.id,
      voterId: voterId,
      optionIds: optionIds,
    );
    return _applyPollResult(post, result);
  }

  @override
  Future<Either<Failure, Post>> retractPollVote({
    required Post post,
    required String voterId,
  }) async {
    final poll = post.poll;
    if (poll == null) {
      return left(NetworkFailure(message: 'Post has no poll', error: 'poll'));
    }
    final result = await pollRemoteDataSource.retractVote(
      pollId: poll.id,
      voterId: voterId,
    );
    return _applyPollResult(post, result);
  }

  @override
  Future<Either<Failure, PaginatedData<PollVoter>>> getPollVoters({
    required int pollId,
    int? optionId,
    required int page,
    required int pageSize,
  }) async {
    final result = await pollRemoteDataSource.getVoters(
      pollId: pollId,
      optionId: optionId,
      page: page,
      pageSize: pageSize,
    );
    return result.fold(
      (failure) => left(failure),
      (voters) => right(
        PaginatedData(
          results: voters.results.map((e) => e.toEntity()).toList(),
          count: voters.count,
          next: voters.next,
          previous: voters.previous,
        ),
      ),
    );
  }
}
