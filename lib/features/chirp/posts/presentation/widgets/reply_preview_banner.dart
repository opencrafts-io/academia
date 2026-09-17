import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Chip-like banner shown above the composer while replying to a comment:
/// bold, tonal color against the composer's plain surface fill so the two
/// read as distinct layers (shape/color contrast) rather than one blob.
class ReplyPreviewBanner extends StatelessWidget {
  const ReplyPreviewBanner({
    super.key,
    required this.replyingTo,
    required this.onCancel,
  });

  final Comment replyingTo;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      key: ValueKey('reply_preview_${replyingTo.authorId}'),
      create: (context) => ChirpUserCubit(
        getChirpUserByIdUsecase: sl(),
        getChirpUserByUsernameUsecase: sl(),
      )..getChirpUserByID(replyingTo.authorId),
      child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
        builder: (context, state) {
          final username = state is ChirpUserLoadedState
              ? (state.user.username ?? 'Unknown User')
              : 'Unknown User';
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.reply_rounded,
                      size: 16,
                      color: colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Replying to @$username',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: colorScheme.onSecondaryContainer),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 16),
                      color: colorScheme.onSecondaryContainer,
                      onPressed: onCancel,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinkifiedText(
                  text: replyingTo.content,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondaryContainer.withAlpha(220),
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  selectable: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
