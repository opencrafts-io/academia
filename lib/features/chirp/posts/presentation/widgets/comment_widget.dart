import 'package:flutter/material.dart';
import 'package:academia/features/chirp/posts/domain/entities/post_replies.dart';

class CommentWidget extends StatelessWidget {
  final PostReply reply;
  final Function(PostReply) onReplyTo;
  final String Function(DateTime) formatTime;
  final Function(PostReply, bool)?
  onVote; // TODO: not yet implemented
  final int maxDepth;

  const CommentWidget({
    super.key,
    required this.reply,
    required this.onReplyTo,
    required this.formatTime,
    this.onVote,
    this.maxDepth = 10,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasReplies = reply.replies.isNotEmpty;
    final isNested = reply.depth > 0;
    final indentWidth = 10.0;
    final shouldShowThreadLine = isNested && reply.depth < maxDepth;

    return Container(
      margin: EdgeInsets.only(left: reply.depth * indentWidth),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Threading line for nested comments
            if (shouldShowThreadLine)
              Container(
                width: 1,
                margin: const EdgeInsets.only(right: 8, left: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(50),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),

            // Main comment content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommentContent(context),

                  // Nested replies
                  if (hasReplies && reply.depth < maxDepth)
                    ...reply.replies.map(
                      (nestedReply) => Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: CommentWidget(
                          reply: nestedReply,
                          onReplyTo: onReplyTo,
                          formatTime: formatTime,
                          onVote: onVote,
                          maxDepth: maxDepth,
                        ),
                      ),
                    ),

                  // "Show more replies" button for deeply nested comments
                  if (hasReplies && reply.depth >= maxDepth)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: GestureDetector(
                        onTap: () {
                          // Handle showing more replies
                        },
                        child: Text(
                          'Show ${reply.replies.length} more ${reply.replies.length == 1 ? 'reply' : 'replies'}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: reply.depth > 0 ? colorScheme.surface : Colors.transparent,
        borderRadius: reply.depth > 0 ? BorderRadius.circular(8) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info row
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: colorScheme.primaryContainer,
                backgroundImage: reply.userAvatar != null
                    ? NetworkImage(reply.userAvatar!)
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                reply.userName,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              // const SizedBox(width: 6),


              const SizedBox(width: 6),
              Text(
                formatTime(reply.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withAlpha(200),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Comment content
          Text(reply.content, style: theme.textTheme.bodyMedium),

          const SizedBox(height: 12),

          // Action row (votes, reply, etc.)
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Reply button
              GestureDetector(
                onTap: () => onReplyTo(reply),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.reply,
                      size: 18,
                      color: colorScheme.onSurfaceVariant.withAlpha(200),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Reply',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant.withAlpha(200),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

            
            ],
          ),
        ],
      ),
    );
  }
}
