import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_state.freezed.dart';

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState.initial() = FeedInitial;
  const factory FeedState.loading() = FeedLoading;
  const factory FeedState.paginationLoading({
    required List<Post> existingPosts,
    required bool hasMore,
  }) = FeedPaginationLoading;
  const factory FeedState.loaded({
    required List<Post> posts,
    String? next,
    String? previous,
    required int count,
    @Default(false) bool hasMore,
  }) = FeedLoaded;
  const factory FeedState.paginationError({
    required List<Post> existingPosts,
    required String message,
    required bool hasMore,
  }) = FeedPaginationError;
  const factory FeedState.error({required String message}) = FeedError;
  const factory FeedState.postDetailLoading() = PostDetailLoading;
  const factory FeedState.postDetailLoaded({required Post post}) =
      PostDetailLoaded;
  const factory FeedState.postDetailError({required String message}) =
      PostDetailError;
  const factory FeedState.postCreating() = PostCreating;
  const factory FeedState.postCreated({required List<Post> posts}) =
      PostCreated;
  const factory FeedState.postCreateError(String message) = PostCreateError;

  /// Emitted when a like/unlike API call fails.
  /// The [post] is the original pre-toggle version for UI rollback.
  const factory FeedState.postLikeError({
    required Post post,
    required String message,
  }) = PostLikeError;
}
