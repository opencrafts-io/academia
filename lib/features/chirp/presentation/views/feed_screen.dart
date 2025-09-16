import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:academia/features/chirp/presentation/widgets/post_card_widget.dart';
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
          // if (state is FeedLoaded) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text("Feed refreshed"),
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          // }
          if (state is FeedLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Refreshing your feed"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(CacheFeedEvent());
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                        return PostCard(
                          post: state.posts[index],
                          onTap: () {
                            context.push(
                              '/post/${state.posts[index].id}',
                              extra: state.posts[index],
                            );
                          },
                        );
                      },
                      itemCount: state.posts.length,
                    );
                  }
                  if (state is FeedLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  if (state is FeedError) {
                    return SliverFillRemaining(
                      child: Center(child: Text("Connection error")),
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addPostBtn",
            onPressed: () async {
              final created = await context.push("/add-post");
              if (created == true && context.mounted) {
                context.read<FeedBloc>().add(CacheFeedEvent());
              }
            },
            child: const Icon(Icons.post_add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "addCommunityBtn",
            onPressed: () {
              CreateCommunitiesRoute().push(context);
            },
            child: const Icon(Icons.group_add),
          ),
        ],
      ),
    );
  }
}
