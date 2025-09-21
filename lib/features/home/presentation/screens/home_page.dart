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
  @override
  void initState() {
    super.initState();
    context.read<PermissionCubit>().checkPermission(AppPermission.notification);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
              title: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: SearchAnchor.bar(
                  suggestionsBuilder: (context, searchController) {
                    return [];
                  },
                  barElevation: WidgetStatePropertyAll(0),
                  barBackgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  barHintText: "Search for posts, events, friends",
                  barLeading: Icon(Icons.search),
                  viewElevation: 0,
                  isFullScreen: true,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ProfileRoute().push(context);
                  },
                  icon: UserAvatar(scallopDepth: 2),
                ),
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
    );
  }
}
