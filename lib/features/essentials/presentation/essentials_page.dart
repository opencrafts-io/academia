import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
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
          SliverAppBar.large(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Essentials"),
                Text(
                  "Your school life easier. 🫠",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
              IconButton(
                onPressed: () {
                  ProfileRoute().push(context);
                },
                icon: UserAvatar(scallopDepth: 4,numberOfScallops: 8,),
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

          EssentialsInstitutionSection(),

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
