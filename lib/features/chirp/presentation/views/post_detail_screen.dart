import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/presentation/widgets/post_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          Post currentPost = widget.post;

          if (state is FeedLoaded) {
            currentPost = state.posts.firstWhere(
              (p) => p.id == widget.post.id,
              orElse: () => widget.post,
            );
          }

          return _buildPostContent(context, currentPost);
        },
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    hintText: "Add a reply...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    context.read<FeedBloc>().add(
                      AddComment(postId: widget.post.id, content: text),
                    );
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context, Post post) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(title: Text("c/${post.userId}")),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              PostCard(post: post),
              const SizedBox(height: 16),
              Text("Comments", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...post.replies.map(
                (reply) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(radius: 14),
                            const SizedBox(width: 8),
                            Text(
                              "c/${reply.userId}",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatTime(reply.createdAt),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(reply.content),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
