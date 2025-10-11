import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/injection_container.dart';

class CommentsListWidget extends StatelessWidget {
  final List<Comment> comments;
  final Function(Comment) onReplyTo;
  final Function(Comment, bool)? onVote;

  const CommentsListWidget({
    super.key,
    required this.comments,
    required this.onReplyTo,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }

    // Sort replies by creation date before building
    final sortedComments = List<Comment>.from(comments)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedComments.map((reply) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: BlocProvider(
            create: (context) =>
                sl<ChirpUserCubit>()..getChirpUserByID(reply.authorId),
            child: CommentWidget(
              reply: reply,
              onReplyTo: onReplyTo,
              formatTime: _formatTime,
              onVote: onVote,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Format relative time like 3h, 2d, etc.
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    if (diff.inDays < 365) return '${(diff.inDays / 7).floor()}w';
    return '${(diff.inDays / 365).floor()}y';
  }
}
