import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityMembershipPage extends StatefulWidget {
  const CommunityMembershipPage({super.key});

  @override
  State<CommunityMembershipPage> createState() =>
      _CommunityMembershipPageState();
}

class _CommunityMembershipPageState extends State<CommunityMembershipPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CommunityListingCubit>().getPostableCommunities();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<CommunityListingCubit>();
    final state = cubit.state;

    // Check if the user has scrolled near the bottom (85% down)
    final isNearEnd =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.85;

    if (isNearEnd && state is CommunityListingLoadedState) {
      if (!state.hasReachedMax && !state.isLoadingMore) {
        cubit.getPostableCommunities();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildBottomLoader(CommunityListingState state) {
    if (state is CommunityListingLoadedState && state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.only(top: 8, bottom: 24),
        child: Center(child: SpinningScallopIndicator()),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<CommunityListingCubit>().getPostableCommunities(page: 1);
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: BlocConsumer<CommunityListingCubit, CommunityListingState>(
          listener: (context, state) {
            if (state is CommunityListingErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final communities = state is CommunityListingLoadedState
                ? state.communities
                : [];

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverAppBar.large(
                  centerTitle: true,
                  floating: true,
                  snap: true,
                  pinned: true,
                  title: Text("Your communities"),
                ),

                // Handle initial loading
                if (state is CommunityListingLoadingState &&
                    communities.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // // Handle initial empty state or error with no communities
                if (communities.isEmpty)
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state is CommunityListingErrorState
                              ? "Failed to load communities: ${state.message}"
                              : "You are not enrolled to any communities at the moment",
                        ),
                      ],
                    ),
                  )
                else
                  // Display the list of communities
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.builder(
                      // +1 for the bottom loader widget
                      itemCount: communities.length + 1,
                      itemBuilder: (context, index) {
                        // The last item is the loading indicator
                        if (index == communities.length) {
                          return _buildBottomLoader(state);
                        }

                        final community = communities[index];
                        return BlocProvider(
                          create: (context) => sl<ChirpUserCubit>(),
                          child: CommunityCard(community: community),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  const CommunityCard({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    context.read<ChirpUserCubit>().getChirpUserByID(community.creatorId);
    return Card.outlined(
      color: Theme.of(context).colorScheme.surfaceDim,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => CommunitiesRoute(communityId: community.id).push(context),
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: community.profilePictureUrl == null
                        ? null
                        : CachedNetworkImageProvider(
                            community.profilePictureUrl!,
                            errorListener: (error) {},
                          ),
                    child: community.profilePictureUrl == null
                        ? Text(community.name[0])
                        : null,
                  ),
                  SizedBox(width: 12),
                  Text(
                    community.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),

              SizedBox(height: 4),
              BlocBuilder<ChirpUserCubit, ChirpUserState>(
                builder: (context, state) {
                  if (state is ChirpUserLoadedState) {
                    return Text(
                      "Created by @${state.user.username ?? 'Anonymous'}",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text("Created by ...");
                },
              ),
              SizedBox(height: 4),
              Text(
                community.description ??
                    'No community description at the moment.',
              ),
              SizedBox(height: 8),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 180,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: CachedNetworkImage(
                  imageUrl: community.banner ?? '',
                  errorWidget: (context, error, child) => Image.asset(
                    "assets/illustrations/community.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.group),
                  SizedBox(width: 4),
                  Text("${community.memberCount} members"),
                  Spacer(),
                  FilledButton(
                    onPressed: () {
                      CommunitiesRoute(communityId: community.id).push(context);
                    },
                    child: Text("View"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
