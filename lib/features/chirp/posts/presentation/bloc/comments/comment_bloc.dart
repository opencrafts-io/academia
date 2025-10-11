// import 'package:academia/features/chirp/posts/posts.dart';
// import 'package:equatable/equatable.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_event.dart';
part 'comment_state.dart';

// class CommentBloc extends Bloc<CommentEvent, CommentState> {
//   final AddCommentUsecase addComment;

//   CommentBloc({required this.addComment}) : super(CommentInitial()) {
//     on<AddComment>(_onAddComment);
//   }

//   Future<void> _onAddComment(
//     AddComment event,
//     Emitter<CommentState> emit,
//   ) async {
//     emit(CommentAdding());

//     final result = await addComment(
//       postId: event.postId,
//       authorId: event.authorId,
//       content: event.content,
//       parentId: event.parentId,
//     );

//     result.fold(
//       (failure) => emit(CommentAddError(failure.message)),
//       (newComment) => emit(CommentAdded(comment: newComment)),
//     );
//   }
// }
