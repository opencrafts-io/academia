import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPosts getFeedPosts;
  final CachePostsUsecase cachePosts;
  final CreatePostUsecase createPost;
  final LikePostUsecase likePost;
  final CommentUsecase addComment;

  FeedBloc({
    required this.getFeedPosts,
    required this.cachePosts,
    required this.createPost,
    required this.likePost,
    required this.addComment,
  }) : super(FeedInitial()) {
    on<LoadFeedEvent>((event, emit) async {
      emit(FeedLoading());

      final result = await getFeedPosts(NoParams());

      await result.fold(
        // Failure from cache - fallback to remote
        (failure) async {
          final remote = await cachePosts(NoParams());
          remote.fold(
            (fail) => emit(FeedError(message: fail.message)),
            (posts) => emit(FeedLoaded(posts: posts)),
          );
        },
        (posts) async {
          if (posts.isEmpty) {
            // Empty cache -fallback to remote
            final remote = await cachePosts(NoParams());
            remote.fold(
              (fail) => emit(FeedError(message: fail.message)),
              (posts) => emit(FeedLoaded(posts: posts)),
            );
          } else {
            emit(FeedLoaded(posts: posts));
          }
        },
      );
    });

    on<CacheFeedEvent>((event, emit) async {
      if (state is! FeedLoaded) {
        emit(FeedLoading());
      }

      final result = await cachePosts(NoParams());

      result.fold(
        (failure) {
          if (state is! FeedLoaded) {
            emit(FeedError(message: failure.message));
          }
        },
        (posts) {
          if (state is FeedLoaded) {
            emit(FeedLoaded(posts: posts));
          } else {
            emit(FeedLoaded(posts: posts));
          }
        },
      );
    });

    on<CreatePostEvent>((event, emit) async {
      emit(PostCreating());

      final attachments = await Future.wait(
        event.files.map((file) async {
          return MultipartFile.fromFile(file.path!, filename: file.name);
        }),
      );

      final result = await createPost(
        content: event.content,
        attachments: attachments,
      );

      result.fold((failure) => emit(PostCreateError(failure.message)), (
        post,
      ) {
        emit(PostCreated());
        add(CacheFeedEvent());
      });
    });

    on<AddComment>((event, emit) async {
      final res = await addComment(event.postId, event.content);
      res.fold((failure) => emit(FeedError(message: failure.message)), (
        success,
      ) {
        add(CacheFeedEvent());
      });
    });

    on<ToggleLikePost>((event, emit) async {
      if (state is! FeedLoaded) return;
      final currentState = state as FeedLoaded;

      final posts = currentState.posts.map((p) {
        if (p.id == event.postId) {
          return p.copyWith(
            isLiked: !event.isCurrentlyLiked,
            likeCount: event.isCurrentlyLiked
                ? p.likeCount - 1
                : p.likeCount + 1,
          );
        }
        return p;
      }).toList();

      emit(FeedLoaded(posts: posts));

      final res = await likePost(event.postId, event.isCurrentlyLiked);
      res.fold((_) => emit(currentState), (_) => add(CacheFeedEvent()));
    });
  }
}
