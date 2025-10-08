import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:animated_emoji/animated_emoji.dart';

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
                Row(
                  children: [
                    Text("Essentials "),
                    AnimatedEmoji(AnimatedEmojis.salute, repeat: false),
                  ],
                ),
                Text(
                  "Your school life easier. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ProfileRoute().push(context);
                },
                icon: UserAvatar(scallopDepth: 4, numberOfScallops: 12),
              ),
            ],
          ),

          // SliverVisibility(
          //   sliver: SliverPadding(
          //     padding: EdgeInsets.all(12),
          //     sliver: MultiSliver(
          //       children: [
          //         Text(
          //           "Suggested",
          //           style: Theme.of(context).textTheme.titleSmall,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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

          SliverPadding(
            padding: EdgeInsetsGeometry.all(12),
            sliver: MultiSliver(
              children: [
                AnimatedEmoji(AnimatedEmojis.dog, size: 80),
                SizedBox(height: 22),

                Text(
                  "✨ These features are still in testing. We'll let you know as soon as they're ready for you!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
