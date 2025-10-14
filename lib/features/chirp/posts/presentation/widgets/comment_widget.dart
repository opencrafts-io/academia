import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment reply;
  final Function(Comment) onReplyTo;
  final String Function(DateTime) formatTime;
  final Function(Comment, bool)? onVote; // TODO: not yet implemented

  const CommentWidget({
    super.key,
    required this.reply,
    required this.onReplyTo,
    required this.formatTime,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    final hasReplies = reply.replies.isNotEmpty;
    final indentWidth = 10.0;

    return Container(
      // margin: EdgeInsets.only(left: reply.depth * indentWidth),
      margin: EdgeInsets.only(left: 2.0 * indentWidth),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Threading line for nested comments
            // if (shouldShowThreadLine)
            if (hasReplies)
              Container(
                width: 1,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withAlpha(50),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),

            // Main comment content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentContentWidget(
                    comment: reply,
                    onReplyTo: onReplyTo,
                    formatTime: formatTime,
                    onVote: onVote,
                  ),

                  if (reply.replies.isNotEmpty)
                    CommentRepliesListWidget(
                      replies: reply.replies,
                      onReplyTo: onReplyTo,
                      formatTime: formatTime,
                      onVote: onVote,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
