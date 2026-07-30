import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:time_since/time_since.dart';

import '../../../../profile/profile.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

enum Vote { up, down, none }

class _PostCardState extends State<PostCard> {
  /// Downloads the file at [url] to a temp path and returns an [XFile].
  /// Returns null if the download fails.
  Future<XFile?> _downloadAttachment(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last.split('?').first;
      final filePath = '${tempDir.path}/$fileName';
      await Dio().download(
        url,
        filePath,
        options: Options(responseType: ResponseType.bytes),
      );
      return XFile(filePath);
    } catch (_) {
      return null;
    }
  }

  void _showPostOptions(String username) {
    final currentUserId =
        context.read<ProfileBloc>().state is ProfileLoadedState
        ? (context.read<ProfileBloc>().state as ProfileLoadedState).profile.id
        : null;

    final isOwnPost = currentUserId == widget.post.authorId;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Share — available to everyone
              SheetActionTile(
                icon: Icons.share_rounded,
                label: 'Share post',
                containerColor: colorScheme.secondaryContainer,
                onContainerColor: colorScheme.onSecondaryContainer,
                onTap: () async {
                  Navigator.pop(context);
                  final url =
                      'https://academia.opencrafts.io${PostDetailRoute(postId: widget.post.id).location}';
                  final box = context.findRenderObject() as RenderBox?;
                  final sharePositionOrigin = box != null
                      ? box.localToGlobal(Offset.zero) & box.size
                      : null;
                  final text =
                      'Check out this post on Academia:\n\n'
                      '📝 ${widget.post.title}\n\n'
                      '🔗 $url';

                  // Attach the first image if available
                  final imageAttachment = widget.post.attachments
                      .where((a) => a.attachmentType.toLowerCase() == 'image')
                      .firstOrNull;

                  if (imageAttachment != null) {
                    final xfile = await _downloadAttachment(
                      imageAttachment.file,
                    );
                    if (xfile != null) {
                      await Share.shareXFiles(
                        [xfile],
                        text: text,
                        sharePositionOrigin: sharePositionOrigin,
                      );
                      return;
                    }
                  }

                  Share.share(text, sharePositionOrigin: sharePositionOrigin);
                },
              ),
              if (!isOwnPost) ...[
                SheetActionTile(
                  icon: Icons.block_rounded,
                  label: 'Block user',
                  containerColor: colorScheme.errorContainer,
                  onContainerColor: colorScheme.onErrorContainer,
                  textColor: colorScheme.error,
                  onTap: () {
                    Navigator.pop(context);
                    _showBlockUserDialog(username);
                  },
                ),
                SheetActionTile(
                  icon: Icons.flag_rounded,
                  label: 'Report post',
                  containerColor: colorScheme.errorContainer,
                  onContainerColor: colorScheme.onErrorContainer,
                  textColor: colorScheme.error,
                  onTap: () {
                    Navigator.pop(context);
                    _showReportPostDialog();
                  },
                ),
              ] else ...[
                SheetActionTile(
                  icon: Icons.edit_rounded,
                  label: 'Edit post',
                  containerColor: colorScheme.secondaryContainer,
                  onContainerColor: colorScheme.onSecondaryContainer,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: edit post
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feature coming soon'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Divider(height: 1),
                ),
                SheetActionTile(
                  icon: Icons.delete_rounded,
                  label: 'Delete post',
                  containerColor: colorScheme.errorContainer,
                  onContainerColor: colorScheme.onErrorContainer,
                  textColor: colorScheme.error,
                  onTap: () {
                    Navigator.pop(context);
                    _showDeletePostDialog();
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showBlockUserDialog(String username) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Block User?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to block $username?'),
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
              context.read<BlockBloc>().add(
                BlockUserEvent(userId: widget.post.authorId),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User blocked'),
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

  void _showReportPostDialog() {
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
                          'Report Post',
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
                          'Why are you reporting this post?',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        ...reasons.map((reason) {
                          final isSelected = selectedReason == reason;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: RadioGroup<String>(
                              onChanged: (val) {
                                setState(() => selectedReason = val);
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
                        onPressed: selectedReason == null
                            ? null
                            : () {
                                final reason = selectedReason == 'Other'
                                    ? customReasonController.text.trim()
                                    : selectedReason!;

                                if (reason.isEmpty) return;

                                context.read<ReportBloc>().add(
                                  ReportContentEvent(
                                    reportType: 'post',
                                    entityId: widget.post.id.toString(),
                                    reason: reason,
                                  ),
                                );

                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );

                                Navigator.pop(context);

                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Post reported successfully.',
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

  void _showDeletePostDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Post?'),
        content: const Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: Implement delete post
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
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
                builder: (context, state) {
                  String avatarUrl =
                      'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                  String username = 'Unknown User';

                  if (state is ChirpUserLoadedState) {
                    avatarUrl = state.user.avatarUrl ?? avatarUrl;
                    username = state.user.username ?? 'Unknown User';
                  }

                  return Row(
                    children: [
                      ChirpUserAvatar(
                        avatarUrl: avatarUrl,
                        numberOfScallops: 6,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'a/${widget.post.community.name}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$username • ${timeSince(widget.post.createdAt)}",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => _showPostOptions(username),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: LinkifiedText(
                text: widget.post.title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: LinkifiedText(
                text: widget.post.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              FeedAttachmentCarousel(attachments: widget.post.attachments),
            ],
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BlocProvider(
                // Scope PostCubit for optimistic like state
                create: (_) => PostCubit(widget.post),
                child: PostActionRow(onCommentTap: widget.onTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
