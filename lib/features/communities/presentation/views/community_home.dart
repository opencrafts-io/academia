import 'package:academia/features/communities/presentation/views/community_about.dart';
import 'package:academia/features/communities/presentation/views/community_members.dart';
import 'package:flutter/material.dart';

class CommunityHome extends StatefulWidget {
  final String communityId;

  const CommunityHome({super.key, required this.communityId});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
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
              title: const Text("Community"),
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    // handle actions here
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'add_member',
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
                    Image.asset(
                      "assets/images/tsuyoshi-kozu-pJ_yqFKXHds-unsplash.jpg",
                      fit: BoxFit.cover,
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
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: const CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage("assets/images/statue.jpg"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flutter Devs",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Developers of Flutter",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "123k members",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: () {},
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
              CommunityMembers(communityId: widget.communityId,),
            ],
          ),
        ),
      ),
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
