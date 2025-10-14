import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';

class CommentRepliesListWidget extends StatefulWidget {
  final List<Comment> replies;
  final Function(Comment) onReplyTo;
  final String Function(DateTime) formatTime;
  final Function(Comment, bool)? onVote;

  const CommentRepliesListWidget({
    super.key,
    required this.replies,
    required this.onReplyTo,
    required this.formatTime,
    this.onVote,
  });

  @override
  State<CommentRepliesListWidget> createState() =>
      _CommentRepliesListWidgetState();
}

class _CommentRepliesListWidgetState extends State<CommentRepliesListWidget> {
  bool _showAllReplies = false;

  @override
  Widget build(BuildContext context) {
    final replies = widget.replies;
    // Sort replies by newest first
    final sortedReplies = List<Comment>.from(widget.replies)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final visibleReplies = _showAllReplies
        ? sortedReplies
        : [sortedReplies.first];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...visibleReplies.map(
          (reply) => CommentWidget(
            reply: reply,
            onReplyTo: widget.onReplyTo,
            formatTime: widget.formatTime,
            onVote: widget.onVote,
          ),
        ),
        if (!_showAllReplies && replies.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: GestureDetector(
              onTap: () => setState(() => _showAllReplies = true),
              child: Text(
                'Show ${replies.length - 1} more ${replies.length - 1 == 1 ? 'reply' : 'replies'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
