import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:time_since/time_since.dart';

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
          child: CommentWidget(
            reply: reply,
            onReplyTo: onReplyTo,
            formatTime: timeSince,
            onVote: onVote,
          ),
        );
      }).toList(),
    );
  }
}
