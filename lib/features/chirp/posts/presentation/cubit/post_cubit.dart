import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<Post> {
  PostCubit(super.post);

  void incrementCommentCount() {
    emit(state.copyWith(commentCount: state.commentCount + 1));
  }

  void updatePost(Post post) => emit(post);

  /// Optimistically toggle the like state locally — call before firing the
  /// [ToggleLikePost] event so the UI updates instantly.
  void toggleLikeOptimistic() {
    final isLiked = state.isLikedByMe;
    emit(
      state.copyWith(
        isLikedByMe: !isLiked,
        upvotes: isLiked
            ? (state.upvotes - 1).clamp(0, double.maxFinite.toInt())
            : state.upvotes + 1,
      ),
    );
  }

  /// Roll back the like state to [original] when the API call fails.
  void rollbackLike(Post original) => emit(original);

  /// Optimistically replace the user's poll selection with [optionIds]
  /// (empty list = retract). Recomputes per-option counts and the distinct
  /// voter total locally — call before firing [VoteOnPollEvent] /
  /// [RetractPollVoteEvent] so bars animate immediately.
  void applyOptimisticVote(List<int> optionIds) {
    final poll = state.poll;
    if (poll == null) return;
    emit(state.copyWith(poll: optimisticPoll(poll, optionIds)));
  }

  /// Roll back the poll state to [original] when the API call fails.
  void rollbackPoll(Post original) => emit(original);

  /// Pure helper: what [poll] looks like after the current user changes their
  /// selection from `poll.myVotes` to [next]. Kept static so it's trivially
  /// unit-testable.
  static Poll optimisticPoll(Poll poll, List<int> next) {
    final previous = poll.myVotes.toSet();
    final selected = next.toSet();

    final options = poll.options.map((o) {
      var count = o.voteCount;
      if (previous.contains(o.id) && !selected.contains(o.id)) count--;
      if (!previous.contains(o.id) && selected.contains(o.id)) count++;
      return o.copyWith(voteCount: count < 0 ? 0 : count);
    }).toList();

    var total = poll.totalVotes;
    if (previous.isEmpty && selected.isNotEmpty) total++;
    if (previous.isNotEmpty && selected.isEmpty) total--;

    return poll.copyWith(
      options: options,
      totalVotes: total < 0 ? 0 : total,
      myVotes: selected.toList(),
    );
  }
}
