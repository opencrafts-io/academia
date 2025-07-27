import 'package:academia/constants/constants.dart';
import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:academia/features/chirp/presentation/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FeedLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Feed refreshed"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state is FeedLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Refreshing your feed"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },

      child: CustomScrollView(
        slivers: [
          BlocBuilder<FeedBloc, FeedState>(
            buildWhen: (previous, current) {
              if (current is FeedLoaded) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is FeedLoaded) {
                return SliverList.builder(
                  itemBuilder: (context, index) {
                    return PostCard(post: (state).posts[index]);
                  },
                  itemCount: state.posts.length,
                );
              }
              if (state is FeedLoading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              return SliverFillRemaining(child: Center(child: Text("WTF")));
            },
          ),
        ],
      ),
    );
  }
}
