import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPosts getFeedPosts;
  final CachePostsUsecase cachePosts;

  FeedBloc({required this.getFeedPosts, required this.cachePosts})
    : super(FeedInitial()) {
    on<LoadFeedEvent>((event, emit) async {
      emit(FeedLoading());

      final result = await getFeedPosts(NoParams());

      await result.fold(
        // Failure from cache ->fallback to remote
        (failure) async {
          final remote = await cachePosts(NoParams());
          remote.fold(
            (fail) => emit(FeedError(message: fail.message)),
            (posts) => emit(FeedLoaded(posts: posts)),
          );
        },
        (posts) async {
          if (posts.isEmpty) {
            // Empty cache -> fallback to remote
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
      emit(FeedLoading());
      final result = await cachePosts(NoParams());
      result.fold(
        (failure) => emit(FeedError(message: failure.message)),
        (posts) => emit(FeedLoaded(posts: posts)),
      );
    });
  }
}

