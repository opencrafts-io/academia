import 'package:academia/config/router/routes.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommunityHome extends StatefulWidget {
  final int communityId;

  const CommunityHome({super.key, required this.communityId});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
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
                    Lottie.asset(
                      "assets/lotties/under-maintenance.json",
                      height: 300,
                    ),
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
                await Future.delayed(const Duration(seconds: 2));
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
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar.medium(
                        centerTitle: false,
                        titleSpacing: 0,
                        title: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              context: context,
                              builder: (context) => Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      "Community guidelines",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    ),

                                    Divider(),
                                    state.community.guidelines.isNotEmpty
                                        ? Expanded(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state
                                                  .community
                                                  .guidelines
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  ListTile(
                                                    leading: Text(
                                                      (index + 1).toString(),
                                                    ),
                                                    title: Text(
                                                      state
                                                          .community
                                                          .guidelines[index],
                                                    ),
                                                  ),
                                            ),
                                          )
                                        : Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "No community guidelines"
                                              " were provided by the mods",
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    state.community.profilePictureUrl == null
                                    ? null
                                    : CachedNetworkImageProvider(
                                        state.community.profilePictureUrl!,
                                        errorListener: (error) {},
                                      ),
                                child: state.community.profilePictureUrl == null
                                    ? Text(state.community.name[0])
                                    : null,
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.community.name),
                                  Text(
                                    "${NumberFormat.compact().format(state.community.memberCount)} members",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Builder(
                            builder: (context) => _CommunityActionSection(
                              communityID: widget.communityId,
                            ),
                          ),
                        ],
                      ),

                      SliverPadding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        sliver: MultiSliver(
                          pushPinnedChildren: true,
                          children: [
                            SliverPinnedHeader(
                              child: Text(
                                state.community.description ??
                                    'No description available',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                          context.read<FeedBloc>().add(
                            LoadFeedEvent(page: _currentPage),
                          );
                          await Future.delayed(Duration(seconds: 2));
                        },
                        child: CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            BlocBuilder<FeedBloc, FeedState>(
                              builder: (context, state) {
                                if (state is FeedLoaded &&
                                    state.posts.isEmpty) {
                                  return SliverPadding(
                                    padding: EdgeInsetsGeometry.all(16),
                                    sliver: SliverFillRemaining(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                            "assets/lotties/chat.json",
                                            height: 300,
                                          ),
                                          Text(
                                            "It's a little quiet in here... "
                                            "Youre here early. Spread the word "
                                            "for your friends to join",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                if (state is FeedLoaded) {
                                  return SliverList.builder(
                                    itemBuilder: (context, index) {
                                      return BlocProvider(
                                        create: (context) =>
                                            sl<ChirpUserCubit>()
                                              ..getChirpUserByID(
                                                state.posts[index].authorId,
                                              ),
                                        child: PostCard(
                                          post: state.posts[index],
                                          onTap: () async {
                                            // marking the post as viewed
                                            context.read<FeedBloc>().add(
                                              MarkPostAsViewed(
                                                postId: state.posts[index].id,
                                                viewerId:
                                                    state.posts[index].authorId,
                                              ),
                                            );
                                            final updatedPost = await context
                                                .push(
                                                  PostDetailRoute(
                                                    postId:
                                                        state.posts[index].id,
                                                  ).location,
                                                  extra: state.posts[index],
                                                );

                                            if (!context.mounted) return;

                                            if (updatedPost != null &&
                                                updatedPost is Post) {
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
                                    child: Center(
                                      child: SpinningScallopIndicator(),
                                    ),
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
                                                    ..getChirpUserByID(
                                                      post.authorId,
                                                    ),
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
                                                    ..getChirpUserByID(
                                                      post.authorId,
                                                    ),
                                              child: PostCard(post: post),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          TextButton.icon(
                                            onPressed: () {
                                              context.read<FeedBloc>().add(
                                                LoadFeedEvent(
                                                  page: _currentPage,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.refresh),
                                            label: const Text(
                                              "Retry loading more posts",
                                            ),
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
                                return SliverPadding(
                                  padding: EdgeInsetsGeometry.all(16),
                                  sliver: SliverFillRemaining(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                          "assets/lotties/chat.json",
                                          height: 300,
                                        ),
                                        Text(
                                          "It's a little quiet in here... "
                                          "Let's make some noise! Start following "
                                          "and posting to fill up your feed.",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CommunityActionSection extends StatelessWidget {
  const _CommunityActionSection({super.key, required this.communityID});
  final int communityID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ChirpCommunityMembershipCubit,
      ChirpCommunityMembershipState
    >(
      listener: (context, state) {
        if (state is ChirpCommunityMembershipCommunityLeftState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You've successfully left the community."),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ChirpCommunityMembershipStateLoadingState ||
            state is ChirpCommunityMembershipInitialState) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ChirpCommunityMembershipLoadedState) {
          return IconButton(
            onPressed: () {
              final cubit = context.read<ChirpCommunityMembershipCubit>();
              final communityHomeBloc = context.read<CommunityHomeBloc>();
              final feedBloc = context.read<FeedBloc>();

              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) => Container(
                  height: 320,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "More community actions",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(),
                      SizedBox(height: 12),
                      Visibility(
                        visible:
                            state.membership.role == "super-mod" ||
                            state.membership.role == "mod",
                        child: ListTile(
                          onTap: () {
                            EditCommunityInfoRoute(
                              communityId: communityID,
                            ).push(context);
                          },
                          leading: Icon(Icons.edit),
                          title: Text("Edit community information"),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box_outlined),
                        title: Text("Add post"),
                        onTap: () async {
                          final communityState = communityHomeBloc.state;

                          // Close modal
                          Navigator.of(context).pop();

                          if (communityState is CommunityHomeLoaded) {
                            final result = await context.push(
                              AddPostRoute().location,
                              extra: communityState.community,
                            );

                            if (result == true) {
                              feedBloc.add(
                                LoadPostsForCommunityEvent(
                                  communityID: communityID,
                                  page: 1,
                                ),
                              );
                            }
                          }
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.groups_2),
                        title: Text("View community members"),
                        onTap: () {
                          CommunityMembersRoute(
                            role: "user",
                            communityId: communityID,
                          ).push(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Leave community"),
                        onTap: () {
                          context.pop();
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) => AlertDialog.adaptive(
                              title: Text("Are you sure you want to leave? "),
                              content: Text(
                                "By leaving you will no longer recieve"
                                "updates from this community nor see posts"
                                " from this community",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                    cubit.leaveCommunity(
                                      communityID: communityID,
                                    );
                                  },
                                  child: Text("Im sure"),
                                ),

                                FilledButton(
                                  onPressed: () => context.pop(),
                                  child: Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Visibility(
                        visible: state.membership.role == "super-mod",
                        child: ListTile(
                          onTap: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: Text("Delete this community"),
                                content: Text(
                                  "Are yout absolutely sure you want to delete "
                                  "this community? "
                                  "This is a permanent irreversible action. "
                                  "All associated content, including all posts,"
                                  "chats, images and membership data will be "
                                  "instantly and permanently removed."
                                  "This community cannot be resored. \n\n"
                                  "Proceed only if you understand and accept the"
                                  " outcome.",
                                ),
                                actions: [
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                    onPressed: () async {
                                      context.pop();
                                      BlocProvider.of<CommunityHomeBloc>(
                                        context,
                                      ).add(
                                        DeleteCommunity(
                                          communityID: communityID,
                                        ),
                                      );
                                      context.pop();
                                    },
                                    label: Text("Im sure delete it"),
                                  ),
                                  FilledButton(
                                    onPressed: () => context.pop(),
                                    child: Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text("Delete community"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(Icons.more_vert),
          );
        }
        return Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
          child: FilledButton(
            onPressed: () {
              final cubit = context.read<ChirpCommunityMembershipCubit>();
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: Text("Are you sure you want to join?"),
                  content: Text(
                    "Welcome to the community! "
                    "By joining, you'll be the first to know about exciting updates, "
                    "events, and everything happening here. "
                    "To ensure a smooth experience, please take a moment to review "
                    "the community guidelines set by our moderators. "
                    "Understanding and following these rules will help keep our space "
                    "welcoming and prevent any issues down the road. "
                    "Let's make this community thrive together!",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text("Never mind"),
                    ),
                    FilledButton(
                      onPressed: () {
                        cubit.joinCommunity(communityID: communityID);
                        context.pop();
                      },
                      child: Text("Join Now"),
                    ),
                  ],
                ),
              );
            },
            child: Text("Join"),
          ),
        );
      },
    );
  }
}
