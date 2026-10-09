import 'dart:async';

import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';

import '../../services/post_attachment_uploader.dart';

export 'feed_state.dart';

part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPostsUsecase getFeedPosts;
  final CreatePostUsecase createPost;
  final GetPostDetailUseCase getPostDetail;
  final MarkPostAsViewedUsecase markPostAsViewed;
  final CreatePostAttachmentUsecase createPostAttachment;
  final DeletePostUsecase deletePost;
  final GetPostsFromCommunityUsecase getPostsFromCommunityUsecase;
  final LikePostUsecase likePost;
  final VoteOnPollUsecase voteOnPoll;
  final RetractPollVoteUsecase retractPollVote;
  final CheckPostLikedUsecase checkPostLiked;
  final Logger _logger = Logger();

  FeedBloc({
    required this.getFeedPosts,
    required this.createPost,
    required this.getPostDetail,
    required this.markPostAsViewed,
    required this.createPostAttachment,
    required this.deletePost,
    required this.getPostsFromCommunityUsecase,
    required this.likePost,
    required this.voteOnPoll,
    required this.retractPollVote,
    required this.checkPostLiked,
  }) : super(FeedInitial()) {
    on<LoadPostsForCommunityEvent>(_onLoadPostsForCommunity);
    on<LoadFeedEvent>(_onLoadFeed);
    on<CreatePostEvent>(_onCreatePost);
    on<GetPostDetailEvent>(_onFetchPostDetail);
    on<MarkPostAsViewed>(_onMarkPostAsViewed);
    on<UpdatePostInFeed>(_onUpdatePostInFeed);
    on<ToggleLikePost>(_onToggleLikePost);
    on<VoteOnPollEvent>(_onVoteOnPoll);
    on<RetractPollVoteEvent>(_onRetractPollVote);
    on<CheckFeedLikeStatuses>(_onCheckFeedLikeStatuses);
  }

  Future<void> _onLoadFeed(LoadFeedEvent event, Emitter<FeedState> emit) =>
      _loadPage(
        page: event.page,
        fetch: () => getFeedPosts(page: event.page, pageSize: event.pageSize),
        emit: emit,
      );

  Future<void> _onLoadPostsForCommunity(
    LoadPostsForCommunityEvent event,
    Emitter<FeedState> emit,
  ) => _loadPage(
    page: event.page,
    fetch: () => getPostsFromCommunityUsecase(
      communityId: event.communityID,
      page: event.page,
      pageSize: event.pageSize,
    ),
    emit: emit,
  );

  Future<void> _loadPage({
    required int page,
    required Future<Either<Failure, PaginatedData<Post>>> Function() fetch,
    required Emitter<FeedState> emit,
  }) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (page == 1) {
      emit(FeedLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is FeedLoaded && page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.posts,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is FeedPaginationError && page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.existingPosts,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await fetch();

    result.fold(
      (failure) {
        // Pagination failed, keep previous posts visible
        if (currentState is FeedLoaded && page > 1) {
          emit(
            FeedPaginationError(
              existingPosts: currentState.posts,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is FeedPaginationError && page > 1) {
          // Retry after pagination error failed again
          emit(
            FeedPaginationError(
              existingPosts: currentState.existingPosts,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          // First load failed
          emit(FeedError(message: failure.message));
        }
      },
      (paginatedData) {
        // Append or replace posts depending on the page
        if (currentState is FeedLoaded && page > 1) {
          emit(
            FeedLoaded(
              posts: [...currentState.posts, ...paginatedData.results],
              next: paginatedData.next,
              previous: paginatedData.previous,
              count: paginatedData.count,
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          emit(
            FeedLoaded(
              posts: paginatedData.results,
              next: paginatedData.next,
              previous: paginatedData.previous,
              count: paginatedData.count,
              hasMore: paginatedData.hasMore,
            ),
          );
          // Refresh like statuses after the initial page loads
          if (!isClosed) add(CheckFeedLikeStatuses());
        }
      },
    );
  }

  Future<void> _onCreatePost(
    CreatePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    final previousState = state;
    emit(PostCreating());

    final result = await createPost(
      title: event.title,
      authorId: event.authorId,
      communityId: event.communityId,
      content: event.content,
      poll: event.poll,
    );

    await result.fold(
      (failure) async {
        emit(PostCreateError(failure.message));
      },
      (post) async {
        _logger.i("Post created successfully: ${post.id}");
        _logger.i("Attachments to process: ${event.attachments.length}");

        final uploadedAttachments = await PostAttachmentUploader(
          createPostAttachment: createPostAttachment,
          deletePost: deletePost,
          logger: _logger,
        ).upload(post.id, event.attachments);
        if (uploadedAttachments == null) {
          emit(PostCreateError("Failed to upload attachments. Post deleted."));
          return;
        }

        // If everything succeeded, build an updated post with attachments
        final postWithAttachments = post.copyWith(
          attachments: uploadedAttachments,
        );

        // Emit updated post to UI
        if (previousState is FeedLoaded) {
          final updatedPosts = [postWithAttachments, ...previousState.posts];
          emit(PostCreated(posts: updatedPosts));
          emit(FeedLoaded(posts: updatedPosts, count: previousState.count + 1));
        } else if (previousState is FeedPaginationLoading) {
          final updatedPosts = [
            postWithAttachments,
            ...previousState.existingPosts,
          ];

          emit(PostCreated(posts: updatedPosts));

          // Fallback feed loaded if pagination was active
          emit(
            FeedLoaded(
              posts: updatedPosts,
              count: updatedPosts.length,
              hasMore: true,
            ),
          );
        } else {
          emit(PostCreated(posts: [postWithAttachments]));
          emit(
            FeedLoaded(
              posts: [postWithAttachments],
              next: null,
              previous: null,
              count: 1,
              hasMore: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _onFetchPostDetail(
    GetPostDetailEvent event,
    Emitter<FeedState> emit,
  ) async {
    // If posts already loaded, find it locally
    if (state is FeedLoaded) {
      final feedState = state as FeedLoaded;
      final existingPost = feedState.posts.firstWhere(
        (p) => p.id == event.postId,
        orElse: () => Post(
          id: 0,
          title: '',
          content: '',
          authorId: '',
          comments: [],
          community: Community(
            id: 0,
            name: '',
            visibility: '',
            guidelines: [],
            creatorId: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          upvotes: 0,
          downvotes: 0,
          commentCount: 0,
          viewsCount: 0,
        ),
      );

      if (existingPost.id != 0) {
        emit(PostDetailLoaded(post: existingPost));
        return;
      }
    }

    emit(PostDetailLoading());
    final result = await getPostDetail(postId: event.postId);

    result.fold(
      (failure) => emit(PostDetailError(message: failure.message)),
      (post) => emit(PostDetailLoaded(post: post)),
    );
  }

  Future<void> _onMarkPostAsViewed(
    MarkPostAsViewed event,
    Emitter<FeedState> emit,
  ) async {
    unawaited(markPostAsViewed(postId: event.postId, viewerId: event.viewerId));
  }

  Future<void> _onUpdatePostInFeed(
    UpdatePostInFeed event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      final updatedPosts = currentState.posts.map((p) {
        return p.id == event.updatedPost.id ? event.updatedPost : p;
      }).toList();

      emit(currentState.copyWith(posts: updatedPosts));
    }
  }

  Future<void> _onToggleLikePost(
    ToggleLikePost event,
    Emitter<FeedState> emit,
  ) async {
    final result = await likePost(
      post: event.post,
      voteValue: event.voteValue,
      voterId: event.voterId,
    );

    result.fold(
      (failure) {
        _logger.e('Failed to cast vote: ${failure.message}');
        emit(PostLikeError(post: event.post, message: failure.message));
        if (event.previousState != null) emit(event.previousState!);
      },
      (updatedPost) {
        if (state is FeedLoaded) {
          final currentState = state as FeedLoaded;
          final updatedPosts = currentState.posts.map((p) {
            return p.id == updatedPost.id ? updatedPost : p;
          }).toList();
          emit(currentState.copyWith(posts: updatedPosts));
        }
      },
    );
  }

  /// Monotonic per-post counter so that when several poll mutations for the
  /// same post are in flight (events run concurrently), only the response to
  /// the most recently dispatched one is applied. The server uses replace
  /// semantics, so the latest request always reflects the user's intent.
  final Map<int, int> _pollMutationSeq = {};

  int _nextPollSeq(int postId) =>
      _pollMutationSeq[postId] = (_pollMutationSeq[postId] ?? 0) + 1;

  bool _isLatestPollSeq(int postId, int seq) => _pollMutationSeq[postId] == seq;

  /// Shared success/failure handling for poll mutations.
  ///
  /// The feed list is never mutated optimistically (only the card's
  /// [PostCubit] is), so on failure we only need to signal the rollback via
  /// [PollVoteError] and then re-emit the state that was current so the feed
  /// doesn't get stuck on the error state.
  void _applyPollMutation(
    Emitter<FeedState> emit,
    Either<Failure, Post> result, {
    required Post originalPost,
  }) {
    final current = state;
    result.fold(
      (failure) {
        _logger.e('Poll mutation failed: ${failure.message}');
        emit(PollVoteError(post: originalPost, message: failure.message));
        emit(current);
      },
      (updatedPost) {
        if (current is FeedLoaded) {
          final updatedPosts = current.posts.map((p) {
            return p.id == updatedPost.id ? updatedPost : p;
          }).toList();
          emit(current.copyWith(posts: updatedPosts));
        }
      },
    );
  }

  Future<void> _onVoteOnPoll(
    VoteOnPollEvent event,
    Emitter<FeedState> emit,
  ) async {
    final seq = _nextPollSeq(event.post.id);
    final result = await voteOnPoll(
      post: event.post,
      optionIds: event.optionIds,
      voterId: event.voterId,
    );
    // A newer vote for this post superseded us; its response wins.
    if (!_isLatestPollSeq(event.post.id, seq)) return;
    _applyPollMutation(emit, result, originalPost: event.post);
  }

  Future<void> _onRetractPollVote(
    RetractPollVoteEvent event,
    Emitter<FeedState> emit,
  ) async {
    final seq = _nextPollSeq(event.post.id);
    final result = await retractPollVote(
      post: event.post,
      voterId: event.voterId,
    );
    if (!_isLatestPollSeq(event.post.id, seq)) return;
    _applyPollMutation(emit, result, originalPost: event.post);
  }

  Future<void> _onCheckFeedLikeStatuses(
    CheckFeedLikeStatuses event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    final currentState = state as FeedLoaded;

    final updatedPosts = <Post>[];
    for (final post in currentState.posts) {
      final result = await checkPostLiked(postId: post.id);
      result.fold(
        (failure) {
          updatedPosts.add(post);
        },
        (voteValue) {
          updatedPosts.add(post.copyWith(myVote: voteValue));
        },
      );
    }

    if (!isClosed) {
      emit(currentState.copyWith(posts: updatedPosts));
    }
  }
}
