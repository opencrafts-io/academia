import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentWidget extends StatefulWidget {
  final Post post;
  final Function(Comment) onReplyTo;
  final Function(Comment, bool)? onVote;

  const PostContentWidget({
    super.key,
    required this.post,
    required this.onReplyTo,
    this.onVote,
  });

  @override
  State<PostContentWidget> createState() => _PostContentWidgetState();
}

class _PostContentWidgetState extends State<PostContentWidget> {
  final ScrollController _scrollController = ScrollController();
  int _commentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<CommentBloc>().state;
      if (state is CommentsLoaded && state.hasMore) {
        _commentPage++;
        context.read<CommentBloc>().add(
          GetPostComments(postId: widget.post.id, page: _commentPage),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            PostDetailAppBar(post: widget.post),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PostDetailHeader(post: widget.post),
                  ),
                  if (widget.post.attachments.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    FeedAttachmentCarousel(
                      attachments: widget.post.attachments,
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const PostActionRow(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.comment_outlined, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "${widget.post.commentCount} ${widget.post.commentCount == 1 ? 'Comment' : 'Comments'}",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ..._commentsSection(state),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _commentsSection(CommentState state) {
    if (state is CommentsLoading) {
      return const [CommentSkeletonLoader()];
    }

    if (state is CommentsLoaded && state.comments.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.icons.messageBubble.image(height: 140),
                const SizedBox(height: 8),
                Text(
                  "No comments yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Be the first to share your thoughts!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    if (state is CommentsLoaded && state.comments.isNotEmpty) {
      return [
        CommentsListWidget(
          comments: state.comments,
          onReplyTo: widget.onReplyTo,
          onVote: widget.onVote,
        ),
      ];
    }

    if (state is CommentsPaginationLoading) {
      return [
        CommentsListWidget(
          comments: state.existingComments,
          onReplyTo: widget.onReplyTo,
          onVote: widget.onVote,
        ),
        const CommentSkeletonLoader(itemCount: 2),
      ];
    }

    if (state is CommentsPaginationError) {
      return [
        CommentsListWidget(
          comments: state.existingComments,
          onReplyTo: widget.onReplyTo,
          onVote: widget.onVote,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextButton.icon(
            onPressed: () {
              context.read<CommentBloc>().add(
                GetPostComments(postId: widget.post.id, page: _commentPage),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Retry loading more comments"),
          ),
        ),
      ];
    }

    if (state is CommentsError) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  "Failed to load comments",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return const [];
  }
}
