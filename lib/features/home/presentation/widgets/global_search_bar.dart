import 'package:flutter/material.dart';

class GlobalSearchBar extends StatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  State<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends State<GlobalSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: SearchAnchor.bar(
          suggestionsBuilder: (context, searchController) {
            return [
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorAnimation: TabIndicatorAnimation.elastic,
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
                        Tab(text: "Posts", icon: Icon(Icons.newspaper)),
                        Tab(text: "Communities", icon: Icon(Icons.group)),
                        Tab(text: "Users", icon: Icon(Icons.account_box)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: TabBarView(
                        children: [
                          Center(child: Text("Posts")),
                          Center(child: Text("Communities")),
                          Center(child: Text("Users")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
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
    );
  }
}
