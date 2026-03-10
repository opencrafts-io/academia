import 'package:academia/config/router/routes.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/gen/assets.gen.dart';
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
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => DraggableScrollableSheet(
                                initialChildSize: 0.6,
                                minChildSize: 0.4,
                                maxChildSize: 0.9,
                                expand: false,
                                builder: (context, scrollController) => Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Community guidelines",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                      const Divider(),
                                      state.community.guidelines.isNotEmpty
                                          ? Expanded(
                                              child: ListView.builder(
                                                controller: scrollController,
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
                                          : const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "No community guidelines"
                                                " were provided by the mods",
                                              ),
                                            ),
                                    ],
                                  ),
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
                                            Assets.lotties.chat,
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
                                          Assets.lotties.chat,
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
  const _CommunityActionSection({required this.communityID});
  final int communityID;

  void _showBlockCommunityDialog(BuildContext context, String communityName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Block Community?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to block $communityName?'),
            const SizedBox(height: 16),
            Text(
              '• You won\'t see posts from this community\n'
              '• You can unblock it anytime from settings',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<BlockBloc>().add(
                BlockCommunityEvent(communityId: communityID),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Blocked $communityName'),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              //Navigate to home page
              context.go('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportCommunityDialog(BuildContext context) {
    String? selectedReason;
    final TextEditingController customReasonController =
        TextEditingController();

    final reasons = [
      'Inappropriate content',
      'Harassment or hate speech',
      'Spam community',
      'Violates platform rules',
      'Other',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Report Community',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: RadioGroup(
                      onChanged: (val) {
                        setState(() => selectedReason = val.toString());
                      },
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(20),
                        children: [
                          Text(
                            'Why are you reporting this community?',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          ...reasons.map((reason) {
                            final isSelected = selectedReason == reason;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: RadioListTile.adaptive(
                                value: reason,
                                title: Text(reason),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                          if (selectedReason == 'Other') ...[
                            const SizedBox(height: 16),
                            TextField(
                              controller: customReasonController,
                              maxLines: 4,
                              maxLength: 500,
                              decoration: InputDecoration(
                                hintText: 'Please provide more details...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedReason == null
                            ? null
                            : () {
                                final reason = selectedReason == 'Other'
                                    ? customReasonController.text.trim()
                                    : selectedReason!;

                                if (reason.isEmpty) return;

                                context.read<ReportBloc>().add(
                                  ReportContentEvent(
                                    reportType: 'community',
                                    entityId: communityID.toString(),
                                    reason: reason,
                                  ),
                                );

                                Navigator.pop(context);

                                ScaffoldMessenger.of(
                                  bottomSheetContext,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Post reported successfully.',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onError,
                        ),
                        child: const Text('Submit Report'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

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

              final communityState = communityHomeBloc.state;
              final communityName = communityState is CommunityHomeLoaded
                  ? communityState.community.name
                  : 'this community';

              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (modalContext) => DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.4,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (context, scrollController) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "More community actions",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Divider(),
                        const SizedBox(height: 12),
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
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit community information"),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.add_box_outlined),
                          title: const Text("Add post"),
                          onTap: () async {
                            final communityState = communityHomeBloc.state;
                            final router = GoRouter.of(context);

                            // Close modal
                            Navigator.of(modalContext).pop();

                            if (communityState is CommunityHomeLoaded) {
                              final result = await router.push(
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

                        // Block Community
                        ListTile(
                          leading: const Icon(Icons.block_outlined),
                          title: const Text("Block Community"),
                          onTap: () {
                            Navigator.pop(modalContext);
                            _showBlockCommunityDialog(context, communityName);
                          },
                        ),

                        // Report Community
                        ListTile(
                          leading: const Icon(Icons.flag_outlined),
                          title: const Text("Report Community"),
                          onTap: () {
                            Navigator.pop(modalContext);
                            _showReportCommunityDialog(context);
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.groups_2),
                          title: const Text("View community members"),
                          onTap: () {
                            CommunityMembersRoute(
                              role: "user",
                              communityId: communityID,
                            ).push(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text("Leave community"),
                          onTap: () {
                            context.pop();
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: const Text(
                                  "Are you sure you want to leave? ",
                                ),
                                content: const Text(
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
                                    child: const Text("Im sure"),
                                  ),

                                  FilledButton(
                                    onPressed: () => context.pop(),
                                    child: const Text("Cancel"),
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
                                  title: const Text("Delete this community"),
                                  content: const Text(
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
                                      label: const Text("Im sure delete it"),
                                    ),
                                    FilledButton(
                                      onPressed: () => context.pop(),
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            leading: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            title: const Text("Delete community"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.more_vert),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FilledButton(
            onPressed: () {
              final cubit = context.read<ChirpCommunityMembershipCubit>();
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text("Are you sure you want to join?"),
                  content: const Text(
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
                      child: const Text("Never mind"),
                    ),
                    FilledButton(
                      onPressed: () {
                        cubit.joinCommunity(communityID: communityID);
                        context.pop();
                      },
                      child: const Text("Join Now"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Join"),
          ),
        );
      },
    );
  }
}
