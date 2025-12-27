import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:time_since/time_since.dart';

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
            SliverAppBar(
              floating: true,
              pinned: true,
              leading: BackButton(
                color: Theme.of(context).colorScheme.onSurface,
                onPressed: () {
                  final updatedPost = context.read<PostCubit>().state;
                  Navigator.pop(context, updatedPost);
                },
              ),
              actions: [
                IconButton.filled(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Opening Community"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    CommunitiesRoute(
                      communityId: widget.post.community.id,
                    ).push(context);
                  },
                  icon: const Icon(Icons.groups, color: Colors.white),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  BlocProvider(
                    create: (context) =>
                        sl<ChirpUserCubit>()
                          ..getChirpUserByID(widget.post.authorId),
                    child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
                      builder: (context, state) {
                        String avatarUrl =
                            'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                        String username = 'Unknown User';

                        if (state is ChirpUserLoadedState) {
                          avatarUrl = state.user.avatarUrl ??
                              'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                          username = state.user.username ?? 'Unknown User';
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ChirpUserAvatar(
                                    avatarUrl: avatarUrl, numberOfScallops: 6),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'a/${widget.post.community.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$username • ${timeSince(widget.post.createdAt)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.post.title,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(widget.post.content),
                            if (widget.post.attachments.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: widget.post.attachments
                                    .map((attachment) => AttachmentWidget(
                                        attachment: attachment))
                                    .toList(),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.all(2),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                  ),
                                  icon: const Icon(Icons.chat),
                                  onPressed: () {},
                                  label: Text('${widget.post.commentCount}'),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton.icon(
                                  iconAlignment: IconAlignment.start,
                                  onPressed: null,
                                  label:
                                      Text(widget.post.viewsCount.toString()),
                                  icon: const Icon(Icons.visibility),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Comments header with loading indicator
                  Row(
                    children: [
                      const Icon(Icons.comment_outlined, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.post.commentCount} ${widget.post.commentCount == 1 ? 'Comment' : 'Comments'}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Comments section
                  if (state is CommentsLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: SpinningScallopIndicator(),
                      ),
                    ),

                  if (state is CommentsLoaded && state.comments.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Lottie.asset(
                              "assets/lotties/promotional-staff.json",
                              height: 240,
                            ),
                            const SizedBox(height:8),
                            Text(
                              "No comments yet",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Be the first to share your thoughts!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withAlpha(100),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (state is CommentsLoaded && state.comments.isNotEmpty)
                    CommentsListWidget(
                      comments: state.comments,
                      onReplyTo: widget.onReplyTo,
                      onVote: widget.onVote,
                    ),

                  if (state is CommentsPaginationLoading)
                    Column(
                      children: [
                        CommentsListWidget(
                          comments: state.existingComments,
                          onReplyTo: widget.onReplyTo,
                          onVote: widget.onVote,
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: SpinningScallopIndicator(),
                          ),
                        ),
                      ],
                    ),

                  if (state is CommentsPaginationError)
                    Column(
                      children: [
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
                                    GetPostComments(
                                      postId: widget.post.id,
                                      page: _commentPage,
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text("Retry loading more comments"),
                          ),
                        ),
                      ],
                    ),

                  if (state is CommentsError)
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 120),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
