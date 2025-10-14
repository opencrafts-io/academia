import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

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
      final userId = profileState.profile.id;

      setState(() {
        isAddingComment = true;
      });

      context.read<CommentBloc>().add(
        AddComment(
          postId: widget.post.id,
          authorId: userId,
          content: text,
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
      context.read<CommentBloc>().add(GetPostComments(postId: widget.post.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentAdded) {
            _controller.clear();
            setState(() {
              _replyingTo = null;
              isAddingComment = false;
            });

            context.read<PostCubit>().incrementCommentCount();

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Comment added successfully!"),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is CommentAddError) {
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
        child: BlocBuilder<PostCubit, Post>(
          builder: (context, updatedPost) {
            return PostContentWidget(
              post: updatedPost,
              onReplyTo: _onReplyTo,
              onVote: _onVoteComment,
            );
          },
        ),
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
                BlocProvider(
                  key: ValueKey(_replyingTo?.authorId ?? ''),
                  create: (context) => ChirpUserCubit(
                    getChirpUserByIdUsecase: sl(),
                    getChirpUserByUsernameUsecase: sl(),
                  )..getChirpUserByID(_replyingTo?.authorId ?? ''),
                  child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
                    builder: (context, state) {
                      String username = 'Unknown User';

                      if (state is ChirpUserLoadedState) {
                        username = state.user.username ?? 'Unknown User';
                      }
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer.withAlpha(120),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.reply,
                                  size: 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                ),
                                const SizedBox(width: 8),
                                Expanded(child: Text('Replying to @$username')),
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  onPressed: _cancelReply,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                            Text(
                              _replyingTo?.content ?? '',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
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
}
