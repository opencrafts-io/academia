import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return BlocProvider(
      create: (context) => ChirpUserCubit(
        getChirpUserByIdUsecase: sl(),
        getChirpUserByUsernameUsecase: sl(),
      )..getChirpUserByID(comment.authorId),
      child: Dismissible(
        key: ValueKey(comment.id.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainer, // A subtle color for the reply action
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          child: const Icon(Icons.reply),
        ),
        confirmDismiss: (direction) async {
          // Only trigger reply on the intended swipe direction
          if (direction == DismissDirection.startToEnd) {
            onReplyTo(comment);
            // Return false to prevent the item from actually being dismissed/removed
            return Future.value(false);
          }
          return Future.value(false);
        },
        child: Container(
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
                            ? CachedNetworkImageProvider(avatarUrl)
                            : CachedNetworkImageProvider(
                                'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg',
                              ),
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
              Text(
                comment.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
