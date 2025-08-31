import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/communities/presentation/views/community_about.dart';
import 'package:academia/features/communities/presentation/views/community_members.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommunityHome extends StatefulWidget {
  const CommunityHome({super.key});

  @override
  State<CommunityHome> createState() => _CommunityHomeState();
}

class _CommunityHomeState extends State<CommunityHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              pinned: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("Community"),
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert), // the ellipsis
                  onSelected: (value) {
                    switch (value) {
                      case 'add_member':
                        // handle add member
                        break;
                      case 'view_members':
                        // handle view members
                        break;
                      case 'leave_group':
                        // handle leave group
                        break;
                      case 'delete_group':
                        // handle delete group
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'add_member',
                      child: ListTile(
                        leading: Icon(Icons.person_add),
                        title: Text("Add Member"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'view_members',
                      child: ListTile(
                        leading: Icon(Icons.group),
                        title: Text("View Members"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'leave_group',
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Leave Group"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete_group',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text("Delete Group"),
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
      
            // Profile image + details (side by side)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile image
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: const CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage("assets/images/statue.jpg"),
                      ),
                    ),
                    const SizedBox(width: 16),
      
                    // Community name, members, button
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
      
            SliverPinnedHeader(
              child: TabBar(
                isScrollable: true,
                dividerHeight: 0,
                tabAlignment: TabAlignment.center,
                tabs: [
                  Tab(child: Text("Posts")),
                  Tab(child: Text("About")),
                  Tab(child: Text("Members")),
                ],
              ),
            ),
            SliverFillRemaining(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveBreakPoints.tablet,
                  ),
                  child: TabBarView(
                    children: [
                      Center(child: Text("Posts Page")),
                      CommunityAbout(),
                      CommunityMembers(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
