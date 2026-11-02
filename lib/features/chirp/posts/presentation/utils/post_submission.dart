import 'package:academia/features/chirp/posts/presentation/bloc/posts/feed_bloc.dart';

/// Dispatches [event] and resolves with the bloc's verdict: [PostCreated] or
/// [PostCreateError] (including a timeout).
Future<FeedState> submitPost(FeedBloc feedBloc, CreatePostEvent event) {
  feedBloc.add(event);
  return feedBloc.stream
      .firstWhere((state) => state is PostCreated || state is PostCreateError)
      .timeout(
        const Duration(seconds: 120),
        onTimeout: () => const FeedState.postCreateError(
          "Post submission timed out. Please try again.",
        ),
      );
}
