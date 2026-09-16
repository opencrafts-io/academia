import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../profile/profile.dart';

/// Vote/comment/views row shared by the feed card and the post detail
/// screen - both drove an identical [PostCubit]/[FeedBloc] wiring (optimistic
/// vote, rollback + snackbar on [PostLikeError]) from two independently
/// maintained copies; [onCommentTap] is the only thing that differs between
/// them (open the detail screen vs. no-op, already there).
class PostActionRow extends StatelessWidget {
  const PostActionRow({super.key, this.onCommentTap});

  /// Null on the detail screen itself - there's nowhere further to go.
  final VoidCallback? onCommentTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (_, current) =>
          current is PostLikeError ||
          current is FeedLoaded ||
          current is FeedPaginationLoading ||
          current is FeedPaginationError,
      listener: (context, state) {
        final postId = context.read<PostCubit>().state.id;

        if (state is PostLikeError && state.post.id == postId) {
          // Roll back to original pre-toggle state
          context.read<PostCubit>().rollbackLike(state.post);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to update like',
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }

        // Sync cubit when FeedBloc's post list has a fresher version of
        // this post (e.g. liked/unliked from the detail page).
        List<Post>? posts;
        if (state is FeedLoaded) {
          posts = state.posts;
        } else if (state is FeedPaginationLoading) {
          posts = state.existingPosts;
        } else if (state is FeedPaginationError) {
          posts = state.existingPosts;
        }
        if (posts != null) {
          final updated = posts.where((p) => p.id == postId);
          if (updated.isNotEmpty) {
            context.read<PostCubit>().updatePost(updated.first);
          }
        }
      },
      builder: (context, _) {
        return BlocBuilder<PostCubit, Post>(
          builder: (context, post) {
            return Row(
              children: [
                PostVoteButton(
                  upvotes: post.upvotes,
                  downvotes: post.downvotes,
                  myVote: post.myVote,
                  onUpvote: () => _vote(context, post, upvote: true),
                  onDownvote: () => _vote(context, post, upvote: false),
                ),
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(2),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  onPressed: onCommentTap,
                  label: Text('${post.commentCount}'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  iconAlignment: IconAlignment.start,
                  onPressed: null,
                  label: Text(post.viewsCount.toString()),
                  icon: const Icon(Icons.visibility_outlined),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _vote(BuildContext context, Post post, {required bool upvote}) {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is! ProfileLoadedState) return;
    final cubit = context.read<PostCubit>();
    final previousFeedState = context.read<FeedBloc>().state;
    // Toggle: voting the same direction again retracts the vote.
    final newVote = upvote
        ? (post.myVote == 1 ? 0 : 1)
        : (post.myVote == -1 ? 0 : -1);
    cubit.applyVoteOptimistic(newVote);
    context.read<FeedBloc>().add(
      ToggleLikePost(
        post: post,
        voteValue: newVote,
        voterId: profileState.profile.id,
        previousState: previousFeedState,
      ),
    );
  }
}
