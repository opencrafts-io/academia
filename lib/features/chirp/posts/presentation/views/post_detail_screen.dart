import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _controller = TextEditingController();
  PostReply? _replyingTo;
  bool isAddingComment = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onReplyTo(PostReply reply) {
    setState(() {
      _replyingTo = reply;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
    // Focus on the text field
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onVoteComment(PostReply reply, bool isUpvote) {
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
          postId: widget.post.id,
          content: text,
          userName: userName,
          userId: userId,
          parentId: _replyingTo?.id,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedBloc>().add(GetPostRepliesEvent(postId: widget.post.id));
    });
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
          // Find the current post in the bloc's state
          Post currentPost = widget.post;
          if (state is FeedLoaded) {
            currentPost = state.posts.firstWhere(
              (p) => p.id == widget.post.id,
              orElse: () => widget.post,
            );
          } else if (state is RepliesLoading) {
            currentPost = state.post;
          }

          return _buildPostContent(context, currentPost, state);
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
                          'Replying to @${_replyingTo!.userName}',
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
    final bool hasComments = post.replies.isNotEmpty;

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
              PostCard(post: post),
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
              if (isLoadingReplies && post.replies.isEmpty)
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
              if (hasComments) ..._buildCommentsTree(post.replies),

              const SizedBox(height: 120),
            ]),
          ),
        ),
      ],
    );
  }

  // Helper method to build comments in proper tree structure
  List<Widget> _buildCommentsTree(List<PostReply> replies) {
    // Sort replies by creation date
    final sortedReplies = List<PostReply>.from(replies);
    sortedReplies.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return sortedReplies
        .map(
          (reply) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CommentWidget(
              reply: reply,
              onReplyTo: _onReplyTo,
              formatTime: _formatTime,
              onVote: _onVoteComment,
            ),
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
