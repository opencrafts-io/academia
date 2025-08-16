import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    hintText: "Search for posts, events, friends",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
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
                  Tab(child: Text("Leaderboard")),
                  Tab(child: Text("For you")),
                  Tab(child: Text("Chats")),
                  Tab(child: Text("Sherehe")),
                ],
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
                      Center(child: Text("Leaderboard")),
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
