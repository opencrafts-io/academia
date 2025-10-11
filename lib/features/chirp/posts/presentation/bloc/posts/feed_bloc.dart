import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:academia/features/chirp/posts/domain/usecases/mark_post_as_viewed_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPosts getFeedPosts;
  final CreatePostUsecase createPost;
  final GetPostDetailUseCase getPostDetail;
  final MarkPostAsViewedUsecase markPostAsViewed;
  final GetPostCommentsUsecase getPostComments;
  final AddCommentUsecase addComment;
  // final CachePostsUsecase cachePosts;
  // final LikePostUsecase likePost;

  FeedBloc({
    required this.getFeedPosts,
    required this.createPost,
    required this.getPostDetail,
    required this.markPostAsViewed,
    required this.getPostComments,
    required this.addComment,
    // required this.cachePosts,
    // required this.likePost,
  }) : super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<CreatePostEvent>(_onCreatePost);
    on<GetPostDetailEvent>(_onFetchPostDetail);
    on<MarkPostAsViewed>(_onMarkPostAsViewed);
    on<AddComment>(_onAddComment);

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
    emit(FeedLoading());

    final result = await getFeedPosts(NoParams());

    result.fold(
      (failure) => emit(FeedError(message: failure.message)),
      (posts) => emit(FeedLoaded(posts: posts)),
    );
  }

  Future<void> _onCreatePost(
    CreatePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    final previousState = state;

    emit(PostCreating());

    // Convert XFile attachments to MultipartFile
    final attachments = await Future.wait(
      event.files.map((xfile) async {
        final bytes = await xfile.readAsBytes();
        return MultipartFile.fromBytes(bytes, filename: xfile.name);
      }),
    );

    final result = await createPost(
      attachments: attachments.isEmpty ? null : attachments,
      title: event.title,
      authorId: event.authorId,
      communityId: event.communityId,
      content: event.content,
    );

    result.fold((failure) => emit(PostCreateError(failure.message)), (post) {
      if (previousState is FeedLoaded) {
        final updatedPosts = [post, ...previousState.posts];
        emit(PostCreated(posts: updatedPosts));
        emit(FeedLoaded(posts: updatedPosts));
      } else {
        emit(PostCreated(posts: [post]));
        emit(FeedLoaded(posts: [post]));
      }
    });
  }

  Future<void> _onFetchPostDetail(
    GetPostDetailEvent event,
    Emitter<FeedState> emit,
  ) async {
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
    // Since you said you don't need to handle state or error propagation,
    // we’ll just call the method and not change the state.
    await markPostAsViewed(postId: event.postId, viewerId: event.viewerId);
  }

  // Future<void> _onFetchPostComments(
  //   GetPostCommentsEvent event,
  //   Emitter<FeedState> emit,
  // ) async {
  //   emit(CommentsLoading());

  //   final result = await getPostComments(postId: event.postId);

  //   result.fold(
  //     (failure) => emit(CommentsError(message: failure.message)),
  //     (post) => emit(CommentsLoaded(post: post)),
  //   );
  // }

  Future<void> _onAddComment(AddComment event, Emitter<FeedState> emit) async {
    final result = await addComment(
      postId: event.postId,
      authorId: event.authorId,
      content: event.content,
      parentId: event.parentId,
    );

    result.fold((failure) => emit(CommentAddError(failure.message)), (
      newComment,
    ) {
      if (state is PostDetailLoaded) {
        final currentState = state as PostDetailLoaded;

        List<Comment> updatedComments;

        if (newComment.parent != null) {
          // Recursively update the tree to add this reply under its parent
          updatedComments = _addReplyToParent(
            currentState.post.comments,
            newComment.parent!,
            newComment,
          );
        } else {
          // It's a top-level comment
          updatedComments = [...currentState.post.comments, newComment];
        }

        final updatedPost = currentState.post.copyWith(
          comments: updatedComments,
          commentCount: currentState.post.commentCount + 1,
        );

        emit(CommentAdded(comment: newComment));
        emit(PostDetailLoaded(post: updatedPost));
      } else {
        emit(CommentAddError("Post details not loaded"));
      }
    });
  }

  /// Helper function to recursively find the parent and add the reply
  List<Comment> _addReplyToParent(
    List<Comment> comments,
    int parentId,
    Comment reply,
  ) {
    return comments.map((comment) {
      if (comment.id == parentId) {
        // Found the parent → append the reply
        return comment.copyWith(replies: [...comment.replies, reply]);
      } else if (comment.replies.isNotEmpty) {
        // Search deeper in the tree
        return comment.copyWith(
          replies: _addReplyToParent(comment.replies, parentId, reply),
        );
      } else {
        return comment;
      }
    }).toList();
  }
}
