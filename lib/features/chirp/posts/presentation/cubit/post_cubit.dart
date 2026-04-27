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
}
