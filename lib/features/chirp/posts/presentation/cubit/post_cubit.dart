import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<Post> {
  PostCubit(super.post);

  void incrementCommentCount() {
    emit(state.copyWith(commentCount: state.commentCount + 1));
  }

  void updatePost(Post post) => emit(post);

  // Optimistically apply vote
  void applyVoteOptimistic(int newVote) {
    final oldVote = state.myVote;
    final int upvotesDelta = newVote - oldVote;
    emit(
      state.copyWith(
        myVote: newVote,
        upvotes: state.upvotes + upvotesDelta,
      ),
    );
  }

  // Roll back the votes when the API call fails.
  void rollbackLike(Post original) => emit(original);
}
