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
  bool _isAddingComment = false;

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
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileLoadedState) return;

    // Toggle: voting the same direction again retracts the vote.
    final newVote = isUpvote
        ? (reply.myVote == 1 ? 0 : 1)
        : (reply.myVote == -1 ? 0 : -1);

    context.read<CommentBloc>().add(
      ToggleCommentVote(
        comment: reply,
        voteValue: newVote,
        voterId: profileState.profile.id,
      ),
    );
  }

  void _sendReply(int postId) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      setState(() => _isAddingComment = true);
      context.read<CommentBloc>().add(
        AddComment(
          postId: postId,
          content: text,
          authorId: profileState.profile.id,
          parentId: _replyingTo?.id,
        ),
      );
    }
  }

  void _cancelReply() => setState(() => _replyingTo = null);

  @override
  void initState() {
    super.initState();
    if (widget.initialPost != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CommentBloc>().add(
          GetPostComments(postId: widget.initialPost!.id),
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<FeedBloc>().add(
            GetPostDetailEvent(postId: widget.postId),
          );
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
                _isAddingComment = false;
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
              setState(() => _isAddingComment = false);
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
            canPop: context.canPop(),
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              // canPop was false (deeplink root) — redirect to home.
              context.go(HomeRoute().location);
            },
            child: Scaffold(
              // The composer lives at the bottom of `body`'s Column (see
              // below) rather than in `bottomNavigationBar`, so this is what
              // actually keeps it clear of the keyboard.
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<PostCubit, Post>(
                      builder: (context, updatedPost) => PostContentWidget(
                        post: updatedPost,
                        onReplyTo: _onReplyTo,
                        onVote: _onVoteComment,
                      ),
                    ),
                  ),
                  CommentComposer(
                    controller: _controller,
                    replyingTo: _replyingTo,
                    isSending: _isAddingComment,
                    onSend: () => _sendReply(post.id),
                    onCancelReply: _cancelReply,
                  ),
                ],
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
              this.context.read<CommentBloc>().add(
                GetPostComments(postId: postId),
              );
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
                  leading: BackButton(onPressed: () => _handleBack(context)),
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
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
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
