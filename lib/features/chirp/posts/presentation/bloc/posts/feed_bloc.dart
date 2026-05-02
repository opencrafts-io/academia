import 'package:academia/features/features.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPostsUsecase getFeedPosts;
  final CreatePostUsecase createPost;
  final GetPostDetailUseCase getPostDetail;
  final MarkPostAsViewedUsecase markPostAsViewed;
  final CreatePostAttachmentUsecase createPostAttachment;
  final DeletePostUsecase deletePost;
  final GetPostsFromCommunityUsecase getPostsFromCommunityUsecase;
  final LikePostUsecase likePost;
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
    required this.checkPostLiked,
  }) : super(FeedInitial()) {
    on<LoadPostsForCommunityEvent>(_onLoadPostsForCommunity);
    on<LoadFeedEvent>(_onLoadFeed);
    on<CreatePostEvent>(_onCreatePost);
    on<GetPostDetailEvent>(_onFetchPostDetail);
    on<MarkPostAsViewed>(_onMarkPostAsViewed);
    on<UpdatePostInFeed>(_onUpdatePostInFeed);
    on<ToggleLikePost>(_onToggleLikePost);
    on<CheckFeedLikeStatuses>(_onCheckFeedLikeStatuses);
  }

  Future<void> _onLoadFeed(LoadFeedEvent event, Emitter<FeedState> emit) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(FeedLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is FeedLoaded && event.page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.posts,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is FeedPaginationError && event.page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.existingPosts,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getFeedPosts(
      page: event.page,
      pageSize: event.pageSize,
    );

    result.fold(
      (failure) {
        // Pagination failed, keep previous posts visible
        if (currentState is FeedLoaded && event.page > 1) {
          emit(
            FeedPaginationError(
              existingPosts: currentState.posts,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is FeedPaginationError && event.page > 1) {
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
        if (currentState is FeedLoaded && event.page > 1) {
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

  Future<void> _onLoadPostsForCommunity(
    LoadPostsForCommunityEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(FeedLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is FeedLoaded && event.page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.posts,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is FeedPaginationError && event.page > 1) {
      emit(
        FeedPaginationLoading(
          existingPosts: currentState.existingPosts,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getPostsFromCommunityUsecase(
      communityId: event.communityID,
      page: event.page,
      pageSize: event.pageSize,
    );

    result.fold(
      (failure) {
        // Pagination failed, keep previous posts visible
        if (currentState is FeedLoaded && event.page > 1) {
          emit(
            FeedPaginationError(
              existingPosts: currentState.posts,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is FeedPaginationError && event.page > 1) {
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
        if (currentState is FeedLoaded && event.page > 1) {
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
          // Refresh like statuses after the initial page loads.
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
    );

    await result.fold(
      (failure) async {
        emit(PostCreateError(failure.message));
      },
      (post) async {
        _logger.i("Post created successfully: ${post.id}");
        _logger.i("Attachments to process: ${event.attachments.length}");

        bool attachmentFailed = false;
        final uploadedAttachments = <Attachments>[];

        if (event.attachments.isNotEmpty) {
          for (final xfile in event.attachments) {
            try {
              final bytes = await xfile.readAsBytes();
              final multipartFile = MultipartFile.fromBytes(
                bytes,
                filename: xfile.name,
              );

              final attachResult = await createPostAttachment.call(
                postId: post.id,
                file: multipartFile,
              );

              attachResult.fold(
                (failure) {
                  _logger.e("Attachment upload failed: ${failure.message}");
                  attachmentFailed = true;
                },
                (attachment) {
                  _logger.i(
                    "Attachment uploaded successfully: ${attachment.id}",
                  );
                  uploadedAttachments.add(attachment);
                },
              );

              if (attachmentFailed) break;
            } catch (e) {
              _logger.e("Error preparing attachment: $e");
              attachmentFailed = true;
              break;
            }
          }

          if (attachmentFailed) {
            _logger.w(
              "Deleting post ${post.id} due to failed attachment upload",
            );

            final deleteResult = await deletePost.call(postId: post.id);

            deleteResult.fold(
              (failure) => _logger.e(
                "Failed to delete post after attachment error: ${failure.message}",
              ),
              (_) => _logger.i(
                "Post ${post.id} deleted successfully after rollback",
              ),
            );

            emit(
              PostCreateError("Failed to upload attachments. Post deleted."),
            );
            return;
          }
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
    await markPostAsViewed(postId: event.postId, viewerId: event.viewerId);
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
      isCurrentlyLiked: event.isCurrentlyLiked,
      voterId: event.voterId,
    );

    result.fold(
      (failure) {
        _logger.e('Failed to toggle like: ${failure.message}');
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
        (isLiked) {
          updatedPosts.add(post.copyWith(isLikedByMe: isLiked));
        },
      );
    }

    if (!isClosed) {
      emit(currentState.copyWith(posts: updatedPosts));
    }
  }
}
