import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      // drawer: NavigationDrawer(
      //   selectedIndex: selectedDrawerItem,
      //   onDestinationSelected: (index) {
      //     setState(() {
      //       selectedDrawerItem = index;
      //     });
      //   },
      //   header: Image.asset(
      //     "assets/icons/academia-logo-variant-1.png",
      //     width: 180,
      //   ),
      //   footer: Text("Made with ❤️ by Open Crafts Interactive."),
      //   elevation: 0,
      //
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.all(12),
      //       child: Text(
      //         "Chirp",
      //         style: Theme.of(context).textTheme.titleMedium,
      //       ),
      //     ),
      //     NavigationDrawerDestination(
      //       icon: Icon(Icons.account_box),
      //       label: Text("Community memberships"),
      //       // enabled: selectedDrawerItem == 1,
      //     ),
      //     NavigationDrawerDestination(
      //       icon: Icon(Icons.campaign),
      //       label: Text("Posts"),
      //     ),
      //
      //     Divider(),
      //   ],
      // ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: RefreshIndicator.adaptive(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                stretch: false,
                leading: Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: Image.asset("assets/icons/academia.png"),
                ),
                centerTitle: true,
                title: GlobalSearchBar(),
                actions: [
                  // PopupMenuButton<int>(
                  //   itemBuilder: (context) => [
                  //     PopupMenuItem(value: 1, child: Text("hello")),
                  //   ],
                  // ),
                  PopupMenuButton(
                    child: UserAvatar(scallopDepth: 2),
                    onSelected: (item) {
                      switch (item) {
                        case 1:
                          ProfileRoute().push(context);
                          break;
                        default:
                      }
                    },
                    offset: Offset(-20, 35),
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 4),
                            Text("View profile"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.account_box),
                            SizedBox(width: 4),
                            Text("Community Memberships"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.campaign),
                            SizedBox(width: 4),
                            Text("Your posts"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     ProfileRoute().push(context);
                  //   },
                  //   icon: UserAvatar(scallopDepth: 2),
                  // ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    // Tab(child: Text("Leaderboard")),
                    Tab(child: Text("For you")),
                    Tab(child: Text("Chats")),
                    Tab(child: Text("Sherehe")),
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
                        // Center(child: Text("Leaderboard")),
                        FeedPage(),
                        ConversationsPage(),
                        ShereheHome(),
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
