import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showPostOptions(String username) {
    final currentUserId =
        context.read<ProfileBloc>().state is ProfileLoadedState
        ? (context.read<ProfileBloc>().state as ProfileLoadedState).profile.id
        : null;

    final isOwnPost = currentUserId == widget.post.authorId;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
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
            // Share — available to everyone
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share Post'),
              onTap: () {
                Navigator.pop(context);
                final url =
                    'https://academia.opencrafts.io${PostDetailRoute(postId: widget.post.id).location}';
                final box = context.findRenderObject() as RenderBox?;
                Share.share(
                  'Check out this post on Academia:\n\n'
                  '📝 ${widget.post.title}\n\n'
                  '🔗 $url',
                  sharePositionOrigin: box != null
                      ? box.localToGlobal(Offset.zero) & box.size
                      : null,
                );
              },
            ),
            if (!isOwnPost) ...[
              ListTile(
                leading: Icon(
                  Icons.block_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: const Text('Block User'),
                onTap: () {
                  Navigator.pop(context);
                  _showBlockUserDialog(username);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.flag_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: const Text('Report Post'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportPostDialog();
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit Post'),
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
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: const Text('Delete Post'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeletePostDialog();
                },
              ),
            ],
          ],
        ),
      ),
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ChirpUserCubit, ChirpUserState>(
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
                    ChirpUserAvatar(avatarUrl: avatarUrl, numberOfScallops: 6),
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
            const SizedBox(height: 8),
            LinkifiedText(
              text: widget.post.title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            LinkifiedText(
              text: widget.post.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double attachmentWidth = constraints.maxWidth;
                  final double attachmentHeight = attachmentWidth / (4 / 5);

                  return SizedBox(
                    height: attachmentHeight,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.post.attachments.length,
                      onPageChanged: (index) =>
                          setState(() => currentPage = index),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AttachmentWidget(
                              attachment: widget.post.attachments[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (widget.post.attachments.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.post.attachments.length, (
                      index,
                    ) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                      );
                    }),
                  ),
                ),
            ],
            const SizedBox(height: 8),
            BlocProvider(
              // Scope PostCubit for optimistic like state
              create: (_) => PostCubit(widget.post),
              child: BlocConsumer<FeedBloc, FeedState>(
                listenWhen: (_, current) =>
                    current is PostLikeError ||
                    current is FeedLoaded ||
                    current is FeedPaginationLoading ||
                    current is FeedPaginationError,
                listener: (context, state) {
                  if (state is PostLikeError &&
                      state.post.id == widget.post.id) {
                    // Roll back to original pre-toggle state
                    context.read<PostCubit>().rollbackLike(state.post);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to update like',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onError,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }

                  // Sync cubit when FeedBloc's post list has a fresher version
                  // of this post (e.g. liked/unliked from the detail page).
                  List<Post>? posts;
                  if (state is FeedLoaded) {
                    posts = state.posts;
                  } else if (state is FeedPaginationLoading) {
                    posts = state.existingPosts;
                  } else if (state is FeedPaginationError) {
                    posts = state.existingPosts;
                  }
                  if (posts != null) {
                    final updated = posts.where((p) => p.id == widget.post.id);
                    if (updated.isNotEmpty) {
                      context.read<PostCubit>().updatePost(updated.first);
                    }
                  }
                },
                builder: (context, feedState) {
                  return BlocBuilder<PostCubit, Post>(
                    builder: (context, post) {
                      return Row(
                        children: [
                          // PostLikeButton(
                          //   upvotes: post.upvotes,
                          //   isLiked: post.isLikedByMe,
                          //   onTap: () {
                          //     final profileState = context
                          //         .read<ProfileBloc>()
                          //         .state;
                          //     if (profileState is! ProfileLoadedState) return;
                          //     final cubit = context.read<PostCubit>();
                          //     final previousFeedState = context
                          //         .read<FeedBloc>()
                          //         .state;
                          //     cubit.toggleLikeOptimistic();
                          //     context.read<FeedBloc>().add(
                          //       ToggleLikePost(
                          //         post: post,
                          //         isCurrentlyLiked: post.isLikedByMe,
                          //         voterId: profileState.profile.id,
                          //         previousState: previousFeedState,
                          //       ),
                          //     );
                          //   },
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 10,
                          //     vertical: 6,
                          //   ),
                          //   iconSize: 18,
                          // ),
                          // const SizedBox(width: 8),

                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(2),
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                            icon: const Icon(Icons.chat),
                            onPressed: widget.onTap,
                            label: Text('${post.commentCount}'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            iconAlignment: IconAlignment.start,
                            onPressed: null,
                            label: Text(post.viewsCount.toString()),
                            icon: const Icon(Icons.visibility),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
