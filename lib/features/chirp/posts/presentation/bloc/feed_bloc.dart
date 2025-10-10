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
  // final CachePostsUsecase cachePosts;
  // final LikePostUsecase likePost;
  // final CommentUsecase addComment;
  // final GetPostRepliesUsecase getPostReplies;
  // final CachePostRepliesUsecase cachePostReplies;

  FeedBloc({
    required this.getFeedPosts,
    required this.createPost,
    required this.getPostDetail,
    required this.markPostAsViewed,
    // required this.cachePosts,
    // required this.likePost,
    // required this.addComment,
    // required this.cachePostReplies,
    // required this.getPostReplies,
  }) : super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<CreatePostEvent>(_onCreatePost);
    on<GetPostDetailEvent>(_onFetchPostDetail);
    on<MarkPostAsViewed>(_onMarkPostAsViewed);

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
    await markPostAsViewed(
      postId: event.postId,
      viewerId: event.viewerId,
    );
  }
}
