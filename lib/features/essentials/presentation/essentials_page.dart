import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({super.key});

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text("Essentials"),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
              IconButton(
                onPressed: () {
                  ProfileRoute().push(context);
                },
                icon: UserAvatar(scallopDepth: 2),
              ),
            ],
          ),

          SliverVisibility(
            sliver: SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: MultiSliver(
                children: [
                  Text(
                    "Suggested",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),

          // Institutions
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                Text(
                  "Explore your school",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),

          // Academia's tools
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                Text(
                  "Academia's tools",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
