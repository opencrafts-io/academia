import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _loadNextPage() {
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
            final bloc = context.read<FeedBloc>();
            _loadFeed();
            await bloc.stream
                .firstWhere(
                  (state) => state is FeedLoaded || state is FeedError,
                )
                .timeout(const Duration(seconds: 30), onTimeout: () => bloc.state);
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
              PostListSliver(
                interleaveAds: true,
                onRetry: _loadFeed,
                onRetryPagination: _loadNextPage,
                emptyState: FeedEmptyState(
                  title: "It's a little quiet in here...",
                  message: 'Follow communities and post to fill up your feed.',
                  onRefresh: _loadFeed,
                ),
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
