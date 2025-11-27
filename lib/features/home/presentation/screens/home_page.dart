import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDrawerItem = 0;
  @override
  void initState() {
    super.initState();
    context.read<PermissionCubit>().checkPermission(AppPermission.notification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        onDestinationSelected: (value) {
          switch (value) {
            case 1:
              context.pop();
              CreateCommunitiesRoute().push(context);
              break;
            case 2:
              context.pop();
              CommunityMembershipsRoute().push(context);
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Feature coming soon."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Text(
              "Chirp",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper),
            label: Text("View your posts"),
          ),
          NavigationDrawerDestination(
            selectedIcon: Icon(Icons.group_add),
            icon: Icon(Icons.group_add_outlined),
            label: Text("Create community"),
          ),

          NavigationDrawerDestination(
            icon: Icon(Icons.view_comfy_outlined),
            selectedIcon: Icon(Icons.view_comfy),
            label: Text("View your communities"),
          ),
        ],
      ),
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: RefreshIndicator.adaptive(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                stretch: false,
                centerTitle: true,
                title: GlobalSearchBar(),
                actions: [
                  IconButton(
                    onPressed: () {
                      ProfileRoute().push(context);
                    },
                    icon: UserAvatar(scallopDepth: 4, numberOfScallops: 12),
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    Tab(child: Text("Leaderboard")),
                    Tab(child: Text("For you")),
                    // Tab(child: Text("Sherehe")),
                  ],
                ),
              ),

              SliverPinnedHeader(
                child: BlocConsumer<PermissionCubit, PermissionState>(
                  listener: (context, state) {
                    if (state is PermissionPermanentlyDenied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "You've previously permanently disabled notifications."
                            " Please re-enable them on the phone settings page.",
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PermissionDenied ||
                        state is PermissionPermanentlyDenied) {
                      return PermissionNotificationAlertCard();
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                fillOverscroll: true,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ResponsiveBreakPoints.tablet,
                    ),
                    child: TabBarView(
                      children: [
                        LeaderboardHomepage(),
                        FeedPage(),
                        // ShereheHome(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
