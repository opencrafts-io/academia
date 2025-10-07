import 'package:academia/config/config.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/chirp/chirp.dart';
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
                const SliverAppBar(
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
                // if (communities.isEmpty)
                //   SliverFillRemaining(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Text(
                //           state is CommunityListingErrorState
                //               ? "Failed to load communities: ${state.message}"
                //               : "You are not enrolled to any communities at the moment",
                //         ),
                //       ],
                //     ),
                //   )
                // else
                // Display the list of communities
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    // +1 for the bottom loader widget
                    itemCount: communities.length + 1,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      // The last item is the loading indicator
                      if (index == communities.length) {
                        return _buildBottomLoader(state);
                      }

                      final community = communities[index];
                      return ListTile(
                        isThreeLine: true,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            image: community.profilePicture == null
                                ? null
                                : DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      community.profilePicture!,
                                    ),
                                  ),
                          ),
                          child: Center(
                            child: community.profilePicture == null
                                ? Text(
                                    community.name[0],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  )
                                : null,
                          ),
                        ),
                        title: Text(community.name),
                        subtitle: Text(
                          community.description ?? "No description available",
                        ),
                        subtitleTextStyle: Theme.of(
                          context,
                        ).textTheme.bodySmall,
                        contentPadding: EdgeInsets.zero,
                        // Assuming CommunitiesRoute is a valid GoRouter route or similar
                        onTap: () => CommunitiesRoute(
                          communityId: community.id.toString(),
                        ).push(context),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 0,
                              child: Text("View community"),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Leave community"),
                            ),
                          ],
                        ),
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
