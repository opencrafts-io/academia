import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    _scrollController.dispose();
    super.dispose();
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
                content: Text("Post created successfully!"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is PostCreateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error creating post"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _currentPage = 1;
            context.read<FeedBloc>().add(LoadFeedEvent(page: _currentPage));
            await Future.delayed(const Duration(seconds: 2));
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  if (state is FeedLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: SpinningScallopIndicator()),
                    );
                  }

                  if (state is FeedError) {
                    return SliverFillRemaining(
                      child: Center(child: Text(state.message)),
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

                  if (posts.isEmpty && !isLoadingMore && !hasError) {
                    return SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lotties/chat.json", height: 300),
                            Text(
                              "It's a little quiet in here... "
                              "Let's make some noise! Start following "
                              "and posting to fill up your feed.",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: posts.length + (isLoadingMore || hasError ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < posts.length) {
                        return BlocProvider(
                          create: (context) => sl<ChirpUserCubit>()
                            ..getChirpUserByID(posts[index].authorId),
                          child: PostCard(
                            post: posts[index],
                            onTap: () async {
                              // marking the post as viewed
                              context.read<FeedBloc>().add(
                                    MarkPostAsViewed(
                                      postId: posts[index].id,
                                      viewerId: posts[index].authorId,
                                    ),
                                  );
                              final updatedPost = await context.push(
                                PostDetailRoute(
                                  postId: posts[index].id,
                                ).location,
                                extra: posts[index],
                              );

                              if (!context.mounted) return;

                              if (updatedPost != null && updatedPost is Post) {
                                context.read<FeedBloc>().add(
                                      UpdatePostInFeed(updatedPost),
                                    );
                              }
                            },
                          ),
                        );
                      } else {
                        if (isLoadingMore) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SpinningScallopIndicator(),
                            ),
                          );
                        }
                        if (hasError) {
                          return Center(
                            child: TextButton.icon(
                              onPressed: () {
                                context
                                    .read<FeedBloc>()
                                    .add(LoadFeedEvent(page: _currentPage));
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Retry loading more posts"),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addPostBtn",
        onPressed: () async {
          AddPostRoute().push(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
