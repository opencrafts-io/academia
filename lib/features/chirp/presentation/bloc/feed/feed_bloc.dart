import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPosts getFeedPosts;

  FeedBloc(this.getFeedPosts) : super(FeedLoading()) {
    on<LoadFeedEvent>((event, emit) async {
      emit(FeedLoading());
      final result = await getFeedPosts(NoParams());
      result.fold(
        (failure) => emit(FeedErrorState(message: failure.message)),
        (posts) => emit(FeedLoaded(posts)),
      );
    });
  }
}

