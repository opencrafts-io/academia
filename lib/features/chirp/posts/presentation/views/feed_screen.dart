import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

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
            context.read<FeedBloc>().add(LoadFeedEvent());
            await Future.delayed(Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<FeedBloc, FeedState>(
                buildWhen: (previous, current) =>
                    (current is FeedLoading ||
                    current is FeedLoaded ||
                    current is FeedError),
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
