import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:lottie/lottie.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  late StreamSubscription _blockSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _blockSubscription = context.read<BlockBloc>().stream.listen((state) {
      if (state is BlockActionSuccess) _loadFeed();
    });
    _loadFeed();
  }

  void _loadFeed() {
    _currentPage = 1;
    context.read<FeedBloc>().add(LoadFeedEvent(page: _currentPage));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<FeedBloc>().state;
      if (state is FeedLoaded && state.hasMore) {
        _currentPage++;
        context.read<FeedBloc>().add(LoadFeedEvent(page: _currentPage));
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _blockSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> getPostsWithAds(List<Post> posts) {
    List<Widget> postsWithAds = [];
    const int adInterval = 3;
    for (int i = 0; i < posts.length; i++) {
      postsWithAds.add(
        PostCard(
          post: posts[i],
          onTap: () async {
            context.read<FeedBloc>().add(
              MarkPostAsViewed(
                postId: posts[i].id,
                viewerId: posts[i].authorId,
              ),
            );
            final updatedPost = await context.push(
              PostDetailRoute(postId: posts[i].id).location,
              extra: posts[i],
            );
            if (!context.mounted) return;
            if (updatedPost != null && updatedPost is Post) {
              context.read<FeedBloc>().add(UpdatePostInFeed(updatedPost));
            }
          },
        ),
      );
      if ((i + 1) % adInterval == 0) {
        postsWithAds.add(BannerAdWidget(size: AdSize.banner));
      }
    }
    return postsWithAds;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocListener<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is PostCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post created successfully!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is PostCreateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error creating post'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _loadFeed();
            await Future.delayed(const Duration(seconds: 2));
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  if (state is FeedLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: LoadingIndicatorM3E()),
                    );
                  }

                  if (state is FeedError) {
                    return SliverFillRemaining(
                      child: _FeedErrorState(
                        message: state.message,
                        onRetry: _loadFeed,
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
                    return SliverFillRemaining(
                      child: _FeedEmptyState(onRefresh: _loadFeed),
                    );
                  }

                  final feed = getPostsWithAds(posts);
                  return SliverList.builder(
                    itemCount:
                    feed.length + (isLoadingMore || hasError ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < feed.length) {
                        final item = feed[index];
                        if (item is PostCard) {
                          return BlocProvider(
                            create: (context) =>
                            sl<ChirpUserCubit>()
                              ..getChirpUserByID(item.post.authorId),
                            child: item,
                          );
                        }
                        return item;
                      }
                      if (isLoadingMore) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: LoadingIndicatorM3E(),
                          ),
                        );
                      }
                      if (hasError) {
                        return Center(
                          child: TextButton.icon(
                            onPressed: () => context.read<FeedBloc>().add(
                              LoadFeedEvent(page: _currentPage),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry loading more'),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addPostBtn',
        onPressed: () => AddPostRoute().push(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FeedEmptyState extends StatelessWidget {
  const _FeedEmptyState({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(Assets.lotties.chat, height: 260),
          const SizedBox(height: 16),
          Text(
            "It's a little quiet in here...",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Follow communities and post to fill up your feed.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}


class _FeedErrorState extends StatelessWidget {
  const _FeedErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
          const SizedBox(height: 12),
          Text(
            'Or pull down to refresh',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
