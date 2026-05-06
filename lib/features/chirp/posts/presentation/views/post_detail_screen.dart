import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  final Post? initialPost;

  const PostDetailPage({super.key, required this.postId, this.initialPost});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _controller = TextEditingController();
  Comment? _replyingTo;
  bool isAddingComment = false;

  /// Stores the post fetched via deep-link so we don't re-render
  Post? _resolvedPost;

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
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onVoteComment(Comment reply, bool isUpvote) {
    //TODO: comment upvote functionality
  }

  void _sendReply(int postId) {
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
          postId: postId,
          content: text,
          authorId: userId,
          parentId: _replyingTo?.id,
        ),
      );
    }
  }

  void _cancelReply() {
    setState(() {
      _replyingTo = null;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialPost != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context
            .read<CommentBloc>()
            .add(GetPostComments(postId: widget.initialPost!.id));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context
              .read<FeedBloc>()
              .add(GetPostDetailEvent(postId: widget.postId));
        }
      });
    }
  }

  /// Called when user triggers a back navigation.
  /// If GoRouter has a previous page, pop normally.
  /// If this is a deeplink (no history), go to home.
  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(HomeRoute().location);
    }
  }

  Widget _buildPostContent(Post post) {
    return BlocProvider(
      key: ValueKey('post_cubit_${post.id}'),
      create: (_) => PostCubit(post),
      child: BlocProvider(
        key: ValueKey('chirp_user_${post.authorId}'),
        create: (context) =>
            sl.get<ChirpUserCubit>()..getChirpUserByID(post.authorId),
        child: BlocListener<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is CommentAdded) {
              _controller.clear();
              setState(() {
                _replyingTo = null;
                isAddingComment = false;
              });
              context.read<PostCubit>().incrementCommentCount();
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to add comment: ${state.message}"),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: PopScope(
            // Never allow the default pop — we control the destination
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              final updatedPost = context.read<PostCubit>().state;
              if (context.canPop()) {
                Navigator.pop(context, updatedPost);
              } else {
                context.go(HomeRoute().location);
              }
            },
            child: Scaffold(
              body: BlocBuilder<PostCubit, Post>(
                builder: (context, updatedPost) {
                  return PostContentWidget(
                    post: updatedPost,
                    onReplyTo: _onReplyTo,
                    onVote: _onVoteComment,
                  );
                },
              ),
              bottomSheet: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
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
                                username =
                                    state.user.username ?? 'Unknown User';
                              }
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                      .withAlpha(120),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.reply,
                                          size: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Replying to @$username',
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            size: 16,
                                          ),
                                          onPressed: _cancelReply,
                                          padding: EdgeInsets.zero,
                                          constraints:
                                              const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    LinkifiedText(
                                      text: _replyingTo?.content ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      selectable: false,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      // Input row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              minLines: 1,
                              maxLines: 5,
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
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: IconButton(
                              onPressed: isAddingComment
                                  ? null
                                  : () => _sendReply(post.id),
                              icon: isAddingComment
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: SpinningScallopIndicator(),
                                    )
                                  : const Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If the post was passed directly (normal feed tap), render immediately.
    if (widget.initialPost != null) {
      return _buildPostContent(widget.initialPost!);
    }

    if (_resolvedPost != null) {
      return _buildPostContent(_resolvedPost!);
    }

    return BlocListener<FeedBloc, FeedState>(
      listener: (_, state) {
        if (state is PostDetailLoaded && _resolvedPost == null) {
          final postId = state.post.id;
          // Store the post so subsequent FeedBloc changes don't wipe the UI.
          setState(() => _resolvedPost = state.post);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              this.context
                  .read<CommentBloc>()
                  .add(GetPostComments(postId: postId));
            }
          });
        }
      },
      child: BlocBuilder<FeedBloc, FeedState>(
        // Only rebuild while we are waiting for the post.
        buildWhen: (_, state) =>
            state is PostDetailLoading ||
            state is PostDetailLoaded ||
            state is PostDetailError,
        builder: (context, state) {
          if (state is PostDetailError) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) return;
                _handleBack(context);
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () => _handleBack(context),
                  ),
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load post',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => context.read<FeedBloc>().add(
                            GetPostDetailEvent(postId: widget.postId),
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          // PostDetailLoading or initial state — show spinner.
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) return;
              _handleBack(context);
            },
            child: const Scaffold(
              body: Center(child: SpinningScallopIndicator()),
            ),
          );
        },
      ),
    );
  }
}
