import 'package:academia/features/communities/presentation/bloc/community_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:academia/features/communities/presentation/views/community_about.dart';
import 'package:academia/features/communities/presentation/views/community_members.dart';

class CommunityHome extends StatefulWidget {
  final String communityId;

  const CommunityHome({super.key, required this.communityId});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<CommunityHomeBloc>().add(
      FetchCommunityById(communityId: widget.communityId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityHomeBloc, CommunityHomeState>(
      builder: (context, state) {
        if (state is CommunityHomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CommunityHomeFailure) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        } else if (state is CommunityHomeLoaded) {
          final community = state.community;

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    expandedHeight: MediaQuery.of(context).size.height * 0.25,
                    pinned: true,
                    floating: false,
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: Text(community.name),
                    actions: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          // handle actions
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text("Edit Community Details"),
                            ),
                          ),
                        ],
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (community.bannerUrl != null)
                            CachedNetworkImage(
                              imageUrl: community.bannerUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: Icon(
                                  Icons.broken_image,
                                  size: 48,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onErrorContainer,
                                ),
                              ),
                            )
                          else
                            Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: const Icon(Icons.image, size: 48),
                            ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Profile header under app bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: community.logoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: community.logoUrl!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 80,
                                      height: 80,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 80,
                                          height: 80,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.errorContainer,
                                          child: Icon(
                                            Icons.error,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onErrorContainer,
                                          ),
                                        ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    child: Icon(
                                      Icons.group,
                                      size: 40,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  community.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  community.description,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${community.members.length} members",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                FilledButton(
                                  onPressed: () {
                                    // handle join/leave
                                  },
                                  child: const Text("Join"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.center,
                        dividerHeight: 0,
                        tabs: const [
                          Tab(text: "Posts"),
                          Tab(text: "About"),
                          Tab(text: "Members"),
                        ],
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    Center(child: Text("Community Posts Page")),
                    const CommunityAbout(),
                    CommunityMembers(
                      communityId: widget.communityId,
                      memberNames: state.community.memberNames,
                      moderatorNames: state.community.moderatorNames,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink(); // fallback
      },
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}
