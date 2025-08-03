import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:academia/features/chirp/presentation/widgets/attachment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailPage extends StatefulWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int currentPage = 0;

  final Map<String, bool> _showReplyField = {};
  final Map<String, TextEditingController> _replyControllers = {};

  final TextEditingController _mainReplyController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _mainReplyController.dispose();
    for (final controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is! FeedLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final post = state.posts.firstWhere((p) => p.id == widget.postId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: theme.colorScheme.onPrimary),
                onSelected: (value) {
                  if (value == 'delete') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Delete post tapped')),
                    );
                  } else if (value == 'report') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Report post tapped')),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.redAccent),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'report',
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.orangeAccent),
                        SizedBox(width: 8),
                        Text('Report'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 16),
                    const SizedBox(width: 8),
                    Text('u/${post.userId}', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text(
                      '• ${timeago.format(post.createdAt, locale: 'en_short')}',
                      style: textTheme.labelLarge?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(post.content, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (post.attachments.isNotEmpty)
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width * 0.6),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: post.attachments.length,
                          onPageChanged: (index) => setState(() => currentPage = index),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: AttachmentWidget(attachment: post.attachments[index]),
                          ),
                        ),
                      ),
                      if (post.attachments.length > 1) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(post.attachments.length, (index) {
                            final isSelected = currentPage == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: isSelected ? 10 : 6,
                              height: isSelected ? 10 : 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline,
                              ),
                            );
                          }),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: 24),

                // Post Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.arrow_circle_up), onPressed: () {}),
                         Text('${post.likeCount}'),
                        IconButton(icon: const Icon(Icons.arrow_circle_down), onPressed: () {}),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
                        Text('${post.replies.length}'),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => Share.share('${post.content}\n\nCheck it out on Academia!'),
                    ),
                  ],
                ),

                const Divider(),
                TextField(
                  controller: _mainReplyController,
                  decoration: InputDecoration(
                    hintText: 'Reply to post...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final reply = _mainReplyController.text.trim();
                        if (reply.isNotEmpty) {
                          // TODO: Send reply to post
                          _mainReplyController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reply sent')),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Replies', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                if (post.replies.isEmpty)
                  Text('No comments yet.', style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline))
                else
                  ...post.replies.map((reply) {
                    final isReplying = _showReplyField[reply.userId] ?? false;
                    final controller = _replyControllers.putIfAbsent(
                      reply.userId,
                      () => TextEditingController(),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(radius: 16),
                              const SizedBox(width: 8),
                              Text('u/${reply.userId}', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Text(
                                '• ${timeago.format(reply.createdAt, locale: 'en_short')}',
                                style: textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(reply.content, style: textTheme.bodyLarge),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(icon: const Icon(Icons.arrow_circle_up), onPressed: () {}),
                              const Text('0'),
                              IconButton(icon: const Icon(Icons.arrow_circle_down), onPressed: () {}),
                              const SizedBox(width: 16),
                              TextButton.icon(
                                icon: const Icon(Icons.turn_left),
                                label: const Text("Reply"),
                                onPressed: () {
                                  setState(() {
                                    _showReplyField[reply.userId] = !isReplying;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (isReplying)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Reply to this comment...',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      final text = controller.text.trim();
                                      if (text.isNotEmpty) {
                                        // TODO: Send nested reply
                                        controller.clear();
                                        setState(() {
                                          _showReplyField[reply.userId] = false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Reply submitted')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          const Divider(),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        );
      },
    );
  }
}
