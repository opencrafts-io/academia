import 'package:academia/config/router/routes.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CommunityHome extends StatefulWidget {
  final int communityId;

  const CommunityHome({super.key, required this.communityId});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome> {
  late String currentUserID;
  late String currentUserName;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<FeedBloc>().state;
      if (state is FeedLoaded && state.hasMore) {
        _currentPage++;
        context.read<FeedBloc>().add(
          LoadPostsForCommunityEvent(
            communityID: widget.communityId,
            page: _currentPage,
          ),
        );
      }
    }
  }

  void _loadPosts() {
    _currentPage = 1;
    context.read<FeedBloc>().add(
      LoadPostsForCommunityEvent(communityID: widget.communityId),
    );
  }

  void _loadNextPage() {
    context.read<FeedBloc>().add(
      LoadPostsForCommunityEvent(
        communityID: widget.communityId,
        page: _currentPage,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadedState) {
      currentUserID = profileState.profile.id;
      currentUserName = profileState.profile.name;
    }

    context.read<CommunityHomeBloc>().add(
      FetchCommunityById(communityId: widget.communityId),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FeedBloc>()
            ..add(LoadPostsForCommunityEvent(communityID: widget.communityId)),
      child: BlocConsumer<CommunityHomeBloc, CommunityHomeState>(
        listener: (context, state) {
          if (state is CommunityDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Community deleted"),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is CommunityHomeLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CommunityHomeFailure) {
            return Scaffold(
              appBar: AppBar(title: Text("Community")),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.lotties.underMaintenance, height: 300),
                    Text(
                      "Ooops!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CommunityHomeLoaded) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                final feedBloc = context.read<FeedBloc>();
                _currentPage = 1;
                feedBloc.add(
                  LoadPostsForCommunityEvent(communityID: widget.communityId),
                );
                await feedBloc.stream
                    .firstWhere(
                      (state) => state is FeedLoaded || state is FeedError,
                    )
                    .timeout(
                      const Duration(seconds: 30),
                      onTimeout: () => feedBloc.state,
                    );
              },
              child: BlocProvider(
                create: (context) =>
                    ChirpCommunityMembershipCubit(
                      joinCommunityUsecase: sl(),
                      leaveCommunityUsecase: sl(),
                      getPersonalCommunityMembershipForCommunityUsecase: sl(),
                    )..getPersonalCommunityMembershipForCommunity(
                      communityID: widget.communityId,
                      userID: currentUserID,
                    ),
                child: PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, _) {
                    if (didPop) return;
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(HomeRoute().location);
                    }
                  },
                  child: Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        CommunityAppBar(
                          community: state.community,
                          communityId: widget.communityId,
                        ),
                      ],
                      body: BlocListener<FeedBloc, FeedState>(
                        listener: (context, state) {
                          if (state is PostCreated) {
                            // FeedBloc's own _onCreatePost handler already
                            // prepends the new post to the current FeedLoaded
                            // state - re-dispatching a page-1 load here would
                            // force a FeedLoading transition that briefly
                            // blanks the (already-correct) list.
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
                        child: CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            PostListSliver(
                              onRetry: _loadPosts,
                              onRetryPagination: _loadNextPage,
                              emptyState: const FeedEmptyState(
                                title: "It's a little quiet in here...",
                                message:
                                    "Youre here early. Spread the word for "
                                    "your friends to join",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ), // PopScope
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
