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
  final Logger _logger = Logger();
  // final CachePostsUsecase cachePosts;
  // final LikePostUsecase likePost;

  FeedBloc({
    required this.getFeedPosts,
    required this.createPost,
    required this.getPostDetail,
    required this.markPostAsViewed,
    required this.createPostAttachment,
    required this.deletePost,
    // required this.cachePosts,
    // required this.likePost,
  }) : super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<CreatePostEvent>(_onCreatePost);
    on<GetPostDetailEvent>(_onFetchPostDetail);
    on<MarkPostAsViewed>(_onMarkPostAsViewed);
    on<UpdatePostInFeed>(_onUpdatePostInFeed);

    //   // Helper method to recursively find parent comment and add reply
    //   List<PostReply>? addReplyToParent(
    //     List<PostReply> replies,
    //     String parentId,
    //     PostReply newReply,
    //   ) {
    //     final updatedReplies = <PostReply>[];
    //     bool found = false;

    //     for (final reply in replies) {
    //       if (reply.id == parentId) {
    //         final updatedChildReplies = [...reply.replies, newReply];
    //         final updatedParent = reply.copyWith(replies: updatedChildReplies);
    //         updatedReplies.add(updatedParent);
    //         found = true;
    //       } else {
    //         final updatedNestedReplies = addReplyToParent(
    //           reply.replies,
    //           parentId,
    //           newReply,
    //         );

    //         if (updatedNestedReplies != null) {
    //           final updatedReply = reply.copyWith(replies: updatedNestedReplies);
    //           updatedReplies.add(updatedReply);
    //           found = true;
    //         } else {
    //           updatedReplies.add(reply);
    //         }
    //       }
    //     }

    //     return found ? updatedReplies : null;
    //   }

    //   on<AddComment>((event, emit) async {
    //     if (state is! FeedLoaded) return;
    //     final currentState = state as FeedLoaded;

    //     emit(CommentAdding());

    //     final res = await addComment(
    //       postId: event.postId,
    //       content: event.content,
    //       userName: event.userName,
    //       parentId: event.parentId,
    //       userId: event.userId,
    //     );

    //     res.fold((failure) => emit(CommentError(failure.message)), (newComment) {
    //       final postIndex = currentState.posts.indexWhere(
    //         (p) => p.id == event.postId,
    //       );
    //       if (postIndex == -1) {
    //         emit(CommentError("Post not found"));
    //         return;
    //       }

    //       final postToUpdate = currentState.posts[postIndex];
    //       Post updatedPost;

    //       if (event.parentId == null) {
    //         // Top-level comment - add to post's replies
    //         final updatedReplies = [...postToUpdate.replies, newComment];
    //         updatedPost = postToUpdate.copyWith(
    //           replies: updatedReplies,
    //           commentCount: postToUpdate.commentCount + 1,
    //         );
    //       } else {
    //         // Nested reply - find parent comment and add to its replies
    //         final updatedReplies = addReplyToParent(
    //           postToUpdate.replies,
    //           event.parentId!,
    //           newComment,
    //         );

    //         if (updatedReplies != null) {
    //           updatedPost = postToUpdate.copyWith(
    //             replies: updatedReplies,
    //             commentCount: postToUpdate.commentCount + 1,
    //           );
    //         } else {
    //           emit(CommentError("Parent comment not found"));
    //           return;
    //         }
    //       }

    //       final updatedPosts = List.of(currentState.posts);
    //       updatedPosts[postIndex] = updatedPost;

    //       emit(CommentAdded(comment: newComment));
    //       emit(FeedLoaded(posts: updatedPosts));
    //     });
    //   });

    //   on<ToggleLikePost>((event, emit) async {
    //     if (state is! FeedLoaded) return;

    //     final currentState = state as FeedLoaded;

    //     final res = await likePost(event.postId, event.isCurrentlyLiked);

    //     res.fold(
    //       (failure) {
    //         emit(currentState);
    //       },
    //       (response) {
    //         final updatedPosts = currentState.posts.map((p) {
    //           if (p.id == event.postId) {
    //             return p.copyWith(
    //               isLiked: response['is_liked'],
    //               likeCount: response['like_count'],
    //             );
    //           }
    //           return p;
    //         }).toList();
    //         emit(FeedLoaded(posts: updatedPosts));
    //       },
    //     );
    //   });

    //   on<GetPostRepliesEvent>((event, emit) async {
    //     final currentState = state as FeedLoaded;
    //     final posts = currentState.posts;
    //     final postIndex = posts.indexWhere((p) => p.id == event.postId);
    //     emit(RepliesLoading(post: posts[postIndex]));

    //     if (postIndex == -1) return;

    //     final result = await cachePostReplies(event.postId);

    //     result.fold(
    //       (failure) {
    //         emit(RepliesError(failure.message));
    //       },
    //       (replies) async {
    //         final postToUpdate = posts[postIndex];
    //         final updatedPost = postToUpdate.copyWith(replies: replies);

    //         final newPosts = List<Post>.from(posts);
    //         newPosts[postIndex] = updatedPost;

    //         emit(FeedLoaded(posts: newPosts));
    //       },
    //     );
    //   });
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
        // Emit PostDetailLoaded directly - no API call
        emit(PostDetailLoaded(post: existingPost));
        return;
      }
    }

    //  Step 2: Fallback — fetch from API if not found locally
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
}
