import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // context.read<FeedBloc>().add(LoadFeedEvent(page: _currentPage));
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SnackBar(
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
            await Future.delayed(Duration(seconds: 2));
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  if (state is FeedLoaded) {
                    return SliverList.builder(
                      itemBuilder: (context, index) {
                        return BlocProvider(
                          create: (context) =>
                              sl<ChirpUserCubit>()
                                ..getChirpUserByID(state.posts[index].authorId),
                          child: PostCard(
                            post: state.posts[index],
                            onTap: () async {
                              // marking the post as viewed
                              context.read<FeedBloc>().add(
                                MarkPostAsViewed(
                                  postId: state.posts[index].id,
                                  viewerId: state.posts[index].authorId,
                                ),
                              );
                              final updatedPost = await context.push(
                                PostDetailRoute(
                                  postId: state.posts[index].id,
                                ).location,
                                extra: state.posts[index],
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
                      },
                      itemCount: state.posts.length,
                    );
                  }
                  if (state is FeedLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: SpinningScallopIndicator()),
                    );
                  }
                  if (state is FeedPaginationLoading) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            ...state.existingPosts.map(
                              (post) => BlocProvider(
                                create: (context) =>
                                    sl<ChirpUserCubit>()
                                      ..getChirpUserByID(post.authorId),
                                child: PostCard(post: post),
                              ),
                            ),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SpinningScallopIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is FeedPaginationError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            ...state.existingPosts.map(
                              (post) => BlocProvider(
                                create: (context) =>
                                    sl<ChirpUserCubit>()
                                      ..getChirpUserByID(post.authorId),
                                child: PostCard(post: post),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton.icon(
                              onPressed: () {
                                context.read<FeedBloc>().add(
                                  LoadFeedEvent(page: _currentPage),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Retry loading more posts"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is FeedError) {
                    return SliverFillRemaining(
                      // child: Center(child: Text("Connection error")),
                      child: Center(child: Text(state.message)),
                    );
                  }
                  return const SliverFillRemaining(
                    child: Center(child: Text("Pull to refresh...")),
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
