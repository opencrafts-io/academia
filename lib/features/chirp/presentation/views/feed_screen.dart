import 'package:academia/config/router/routes.dart';
import 'package:academia/core/clippers/clippers.dart';
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
        listener: (context, state) {},
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FeedBloc>().add(CacheFeedEvent());
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
                      child: Center(child: SpinningScallopIndicator()),
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
      floatingActionButton: FloatingActionButton(
        heroTag: "addPostBtn",
        onPressed: () async {
          final created = await context.push("/add-post");
          if (created == true && context.mounted) {
            context.read<FeedBloc>().add(CacheFeedEvent());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
