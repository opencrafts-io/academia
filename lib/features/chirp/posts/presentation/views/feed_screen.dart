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
        listener: (context, state) {},
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
                          create: (context) => sl<ChirpUserCubit>(),
                          child: PostCard(
                            post: state.posts[index],
                            onTap: () {
                              // marking the post as viewed
                              context.read<FeedBloc>().add(
                                MarkPostAsViewed(
                                  postId: state.posts[index].id,
                                  viewerId: state.posts[index].authorId,
                                ),
                              );
                              PostDetailRoute(
                                postId: state.posts[index].id,
                              ).push(context);
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
