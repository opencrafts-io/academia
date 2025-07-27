import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: RefreshIndicator.adaptive(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding: EdgeInsets.all(12),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 420),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(22),
                    ),

                    child: TabBar(
                      isScrollable: true,
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        Tab(child: Text("Chirp Feed")),
                        Tab(child: Text("Chirp Chats")),
                        Tab(child: Text("Sherehe & Inshallah")),
                      ],
                    ),
                  ),
                ),
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
                      FeedPage(),
                      Center(child: Text("Chirp chats")),
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
