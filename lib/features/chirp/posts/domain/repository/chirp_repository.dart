import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChirpRepository {
  Future<Either<Failure, PaginatedData<Post>>> getFeedPosts({
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Post>> getPostDetails({required int postId});

  Future<Either<Failure, Post>> createPost({
    required String title,
    required String authorId,
    required int communityId,
    required String content,
    PollDraft? poll,
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

  Future<Either<Failure, PaginatedData<Post>>> getPostsFromCommunity({
    required int communityId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Post>> toggleLike({
    required Post post,
    required int voteValue,
    required String voterId,
  });

  /// Replaces the user's selection on the post's poll. Returns the updated
  /// [Post] with server-authoritative poll counts and `myVotes`.
  Future<Either<Failure, Post>> voteOnPoll({
    required Post post,
    required List<int> optionIds,
    required String voterId,
  });

  /// Removes all of the user's selections on the post's poll.
  Future<Either<Failure, Post>> retractPollVote({
    required Post post,
    required String voterId,
  });

  Future<Either<Failure, PaginatedData<PollVoter>>> getPollVoters({
    required int pollId,
    int? optionId,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, int>> checkIsLiked({required int postId});

  Future<Either<Failure, Comment>> toggleCommentLike({
    required Comment comment,
    required int voteValue,
    required String voterId,
  });

  Future<Either<Failure, int>> checkIsCommentLiked({required int commentId});
}
