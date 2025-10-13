import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentContentWidget extends StatelessWidget {
  final Comment comment;
  final Function(Comment) onReplyTo;
  final String Function(DateTime) formatTime;
  final Function(Comment, bool)? onVote;

  const CommentContentWidget({
    super.key,
    required this.comment,
    required this.onReplyTo,
    required this.formatTime,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ChirpUserCubit, ChirpUserState>(
            builder: (context, state) {
              String? avatarUrl;
              String username = 'Unknown User';
              if (state is ChirpUserLoadedState) {
                avatarUrl = state.user.avatarUrl;
                username = state.user.username ?? 'Unknown User';
              }

              return Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    backgroundImage: avatarUrl != null
                        ? NetworkImage(avatarUrl)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatTime(comment.createdAt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withAlpha(200),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(comment.content, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => onReplyTo(comment),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.reply,
                  size: 18,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withAlpha(200),
                ),
                const SizedBox(width: 4),
                Text(
                  'Reply',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withAlpha(200),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
