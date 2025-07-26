import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:academia/features/chirp/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chirp'), centerTitle: false),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) =>
                  PostCard(post: state.posts[index]),
            );
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Route to Direct messaging
        },
        child: Icon(Symbols.mail),
      ),
    );
  }
}
