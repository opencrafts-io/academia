import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/domain/usecases/get_feed_posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPosts getFeedPosts;

  FeedBloc(this.getFeedPosts) : super(FeedLoading()) {
    on<LoadFeedEvent>((event, emit) async {
      emit(FeedLoading());
      final posts = await getFeedPosts();
      emit(FeedLoaded(posts));
    });
  }
}

