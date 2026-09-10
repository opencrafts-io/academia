import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

/// Renders the post-list portion of a [FeedBloc]-backed screen (the global
/// feed or a single community's feed) as slivers.
///
/// [FeedBloc] also emits states for post creation, post-detail viewing and
/// like-toggling (`PostCreating`, `PostDetailLoading`, `PostLikeError`, ...)
/// that carry no post list. [buildWhen] here is restricted to the list-shaped
/// cases so those unrelated transitions can't fall through every branch below
/// and blank an already-loaded feed for their duration - e.g. a single failed
/// like no longer wipes the whole list.
class PostListSliver extends StatefulWidget {
  const PostListSliver({
    super.key,
    required this.emptyState,
    required this.onRetry,
    required this.onRetryPagination,
    this.interleaveAds = false,
  });

  /// Shown when the feed loaded successfully but has no posts.
  final Widget emptyState;

  /// Retries a full (page 1) load after [FeedError].
  final VoidCallback onRetry;

  /// Retries the failed page after [FeedPaginationError].
  final VoidCallback onRetryPagination;

  /// Whether to interleave [BannerAdWidget]s every few posts.
  final bool interleaveAds;

  @override
  State<PostListSliver> createState() => _PostListSliverState();
}

class _PostListSliverState extends State<PostListSliver> {
  static const _adInterval = 3;

  // Last list-bearing snapshot. A pull-to-refresh re-dispatches a page-1
  // load, which re-emits a bare FeedLoading() with no posts of its own -
  // kept here so the already-loaded list can stay on screen (with
  // RefreshIndicator's own spinner as the only refresh affordance) instead
  // of the whole feed blanking to a full-screen spinner every refresh.
  List<Post>? _lastPosts;

  static Future<void> _openPost(BuildContext context, Post post) async {
    context.read<FeedBloc>().add(
      MarkPostAsViewed(postId: post.id, viewerId: post.authorId),
    );
    final updatedPost = await context.push(
      PostDetailRoute(postId: post.id).location,
      extra: post,
    );
    if (!context.mounted) return;
    if (updatedPost != null && updatedPost is Post) {
      context.read<FeedBloc>().add(UpdatePostInFeed(updatedPost));
    }
  }

  List<Widget> _items(BuildContext context, List<Post> posts) {
    final items = <Widget>[];
    for (var i = 0; i < posts.length; i++) {
      final post = posts[i];
      items.add(
        BlocProvider(
          key: ValueKey('post_${post.id}'),
          create: (context) =>
              sl<ChirpUserCubit>()..getChirpUserByID(post.authorId),
          child: PostCard(post: post, onTap: () => _openPost(context, post)),
        ),
      );
      if (widget.interleaveAds && (i + 1) % _adInterval == 0) {
        items.add(BannerAdWidget(key: ValueKey('ad_$i')));
      }
    }
    return items;
  }

  Widget _buildList(
    BuildContext context,
    List<Post> posts, {
    required bool isLoadingMore,
    required bool hasError,
  }) {
    final items = _items(context, posts);
    return SliverList.builder(
      itemCount: items.length + (isLoadingMore || hasError ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < items.length) return items[index];
        if (isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: LoadingIndicatorM3E()),
          );
        }
        return Center(
          child: TextButton.icon(
            onPressed: widget.onRetryPagination,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry loading more'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      buildWhen: (previous, current) =>
          current is FeedLoading ||
          current is FeedLoaded ||
          current is FeedError ||
          current is FeedPaginationLoading ||
          current is FeedPaginationError,
      builder: (context, state) {
        if (state is FeedLoaded) {
          _lastPosts = state.posts;
        } else if (state is FeedPaginationLoading) {
          _lastPosts = state.existingPosts;
        } else if (state is FeedPaginationError) {
          _lastPosts = state.existingPosts;
        }

        if (state is FeedLoading) {
          final cached = _lastPosts;
          if (cached != null && cached.isNotEmpty) {
            return _buildList(
              context,
              cached,
              isLoadingMore: false,
              hasError: false,
            );
          }
          return const SliverFillRemaining(
            child: Center(child: LoadingIndicatorM3E()),
          );
        }

        if (state is FeedError) {
          return SliverFillRemaining(
            child: FeedErrorState(
              message: state.message,
              onRetry: widget.onRetry,
            ),
          );
        }

        List<Post> posts = [];
        bool isLoadingMore = false;
        bool hasError = false;

        if (state is FeedLoaded) {
          posts = state.posts;
        } else if (state is FeedPaginationLoading) {
          posts = state.existingPosts;
          isLoadingMore = true;
        } else if (state is FeedPaginationError) {
          posts = state.existingPosts;
          hasError = true;
        }

        if (posts.isEmpty && !isLoadingMore) {
          return SliverFillRemaining(child: widget.emptyState);
        }

        return _buildList(
          context,
          posts,
          isLoadingMore: isLoadingMore,
          hasError: hasError,
        );
      },
    );
  }
}
