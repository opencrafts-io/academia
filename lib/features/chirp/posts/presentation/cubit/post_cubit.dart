import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<Post> {
  PostCubit(super.post);

  void incrementCommentCount() {
    emit(state.copyWith(commentCount: state.commentCount + 1));
  }

  void updatePost(Post post) => emit(post);
}
