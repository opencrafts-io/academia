import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
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

  void _showCommentOptions(
    BuildContext context,
    Comment comment,
    String username,
  ) {
    final currentUserId =
        context.read<ProfileBloc>().state is ProfileLoadedState
        ? (context.read<ProfileBloc>().state as ProfileLoadedState).profile.id
        : null;

    final isOwnComment = currentUserId == comment.authorId;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (!isOwnComment) ...[
              ListTile(
                leading: Icon(
                  Icons.block_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text('Block @$username'),
                onTap: () {
                  Navigator.pop(modalContext);
                  _showBlockUserDialog(context, comment.authorId, username);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.flag_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: const Text('Report Comment'),
                onTap: () {
                  Navigator.pop(modalContext);
                  _showReportCommentDialog(context, comment.id);
                },
              ),
            ] else ...[
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: const Text('Delete Comment'),
                onTap: () {
                  Navigator.pop(modalContext);
                  _showDeleteCommentDialog(context, comment.id);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showBlockUserDialog(
    BuildContext context,
    String userId,
    String username,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Block User?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to block @$username?'),
            const SizedBox(height: 16),
            Text(
              '• You won\'t see their posts or comments\n'
              '• They won\'t be able to message you\n'
              '• You can unblock them anytime',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<BlockBloc>().add(BlockUserEvent(userId: userId));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Blocked @$username'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportCommentDialog(BuildContext context, int commentId) {
    String? selectedReason;
    final TextEditingController customReasonController =
        TextEditingController();

    final reasons = [
      'Spam or misleading',
      'Harassment or hate speech',
      'Violence or dangerous content',
      'Nudity or sexual content',
      'Misinformation',
      'Copyright violation',
      'Other',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Report Comment',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      children: [
                        Text(
                          'Why are you reporting this comment?',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        ...reasons.map((reason) {
                          final isSelected = selectedReason == reason;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: RadioGroup(
                              onChanged: (val) {
                                setState(() => val = reason);
                              },
                              child: RadioListTile.adaptive(
                                value: reason,
                                title: Text(reason),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        if (selectedReason == 'Other') ...[
                          const SizedBox(height: 16),
                          TextField(
                            controller: customReasonController,
                            maxLines: 4,
                            maxLength: 500,
                            decoration: InputDecoration(
                              hintText: 'Please provide more details...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final reason = selectedReason == 'Other'
                              ? customReasonController.text.trim()
                              : selectedReason;

                          if (reason?.isEmpty ?? true) return;

                          final messenger = ScaffoldMessenger.of(context);

                          context.read<ReportBloc>().add(
                            ReportContentEvent(
                              reportType: 'comment',
                              entityId: commentId.toString(),
                              reason: reason ?? 'Other',
                            ),
                          );
                          Navigator.pop(context);
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Thank you for your report. Our team will review it.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onError,
                        ),
                        child: const Text('Submit Report'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteCommentDialog(BuildContext context, int commentId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Comment?'),
        content: const Text(
          'Are you sure you want to delete this comment? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: Implement delete comment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feature coming soon'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('comment_user_${comment.id}_${comment.authorId}'),
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
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert, size: 18),
                        onPressed: () =>
                            _showCommentOptions(context, comment, username),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              LinkifiedText(
                text: comment.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
