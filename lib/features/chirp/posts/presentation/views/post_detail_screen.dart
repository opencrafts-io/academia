import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _controller = TextEditingController();
  Comment? _replyingTo;
  bool isAddingComment = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onReplyTo(Comment reply) {
    setState(() {
      _replyingTo = reply;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
    // Focus on the text field
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onVoteComment(Comment reply, bool isUpvote) {
    //TODO: comment upvote functionality
  }

  void _sendReply() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      final userName = profileState.profile.name;
      final userId = profileState.profile.id;

      setState(() {
        isAddingComment = true;
      });

      context.read<FeedBloc>().add(
        AddComment(
          postId: widget.postId.toString(),
          content: text,
          userName: userName,
          userId: userId,
          parentId: _replyingTo?.id.toString(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User profile not loaded. Please try again."),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _cancelReply() {
    setState(() {
      _replyingTo = null;
      _controller.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<FeedBloc>().add(GetPostDetailEvent(postId: widget.postId));

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<FeedBloc>().add(
    //     GetPostRepliesEvent(postId: widget.postId.toString()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is CommentAdded) {
            _controller.clear();
            setState(() {
              _replyingTo = null;
              isAddingComment = false;
            });

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Comment added successfully!"),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is CommentError) {
            setState(() {
              isAddingComment = false;
            });

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to add comment: ${state.message}"),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostDetailLoaded) {
            return _buildPostContent(context, state.post, state);
          } else if (state is PostDetailLoading) {
            return const SliverFillRemaining(
              child: Center(child: SpinningScallopIndicator()),
            );
          } else if (state is PostDetailError) {
            return SliverFillRemaining(
              child: Center(child: Text(state.message)),
            );
          } else if (state is RepliesLoading) {
            return _buildPostContent(context, state.post, state);
          }
          return const SizedBox.shrink();
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Reply indicator
              if (_replyingTo != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer.withAlpha(120),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        size: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Replying to @${_replyingTo!.authorId}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: _cancelReply,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

              // Input row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => isAddingComment ? null : _sendReply(),
                      enabled: !isAddingComment,
                      decoration: InputDecoration(
                        hintText: _replyingTo != null
                            ? "Write your reply..."
                            : "Add a comment...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withAlpha(isAddingComment ? 100 : 255),
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
                    onPressed: isAddingComment ? null : _sendReply,
                    icon: isAddingComment
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: SpinningScallopIndicator(),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostContent(BuildContext context, Post post, FeedState state) {
    final bool isLoadingReplies = state is RepliesLoading;
    final bool hasComments = post.comments.isNotEmpty;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          actions: [
            IconButton.filled(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Openning Community"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: Icon(Icons.groups, color: Colors.white),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              BlocProvider(
                create: (context) => sl<ChirpUserCubit>(),
                child: PostCard(post: post),
              ),
              const SizedBox(height: 16),

              // Comments header with loading indicator
              Row(
                children: [
                  Icon(Icons.comment_outlined, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "${post.commentCount} ${post.commentCount == 1 ? 'Comment' : 'Comments'}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Comments section
              if (isLoadingReplies && post.comments.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: SpinningScallopIndicator(),
                  ),
                ),

              if (!isLoadingReplies && !hasComments)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Lottie.asset(
                          "assets/lotties/promotional-staff.json",
                          height: 240,
                        ),
                        Text(
                          "No comments yet",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Be the first to share your thoughts!",
                          style: Theme.of(context).textTheme.bodyMedium
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

              // Render comments in proper hierarchical order
              if (hasComments) ..._buildCommentsTree(post.comments),

              const SizedBox(height: 120),
            ]),
          ),
        ),
      ],
    );
  }

  // Helper method to build comments in proper tree structure
  List<Widget> _buildCommentsTree(List<Comment> replies) {
    // Sort replies by creation date
    final sortedReplies = List<Comment>.from(replies);
    sortedReplies.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return sortedReplies
        .map(
          (reply) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            // child: CommentWidget( // TODO: Implement CommentWidget
            //   reply: reply,
            //   onReplyTo: _onReplyTo,
            //   formatTime: _formatTime,
            //   onVote: _onVoteComment,
            // ),
          ),
        )
        .toList();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    if (diff.inDays < 365) return '${(diff.inDays / 7).floor()}w';

    return '${(diff.inDays / 365).floor()}y';
  }
}
