import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:animated_emoji/animated_emoji.dart';
import '../widgets/essential_category_tile.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({super.key});

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialItem {
  final String iconPath;
  final String title;
  final VoidCallback? ontap;

  _EssentialItem({
    required this.title,
    required this.ontap,
    required this.iconPath,
  });
}

class _EssentialsPageState extends State<EssentialsPage> {
  late List<_EssentialItem> essentialItems = <_EssentialItem>[
    _EssentialItem(
      title: "Achievements",
      ontap: () => AchievementsHomePageRoute().push(context),
      iconPath: "assets/icons/medal.png",
    ),
    _EssentialItem(
      title: "To-Dos",
      ontap: () => TodosRoute().push(context),
      iconPath: "assets/icons/todos.png",
    ),

    // _EssentialItem(
    //   title: "Identity",
    //   ontap: null,
    //   iconPath: "assets/icons/card.png",
    // ),
    // _EssentialItem(
    //   title: "Exam timetable",
    //   ontap: null,
    //   iconPath: "assets/icons/exam.png",
    // ),
  ];
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
          EssentialsInstitutionSection(),

          // Academia's tools
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            sliver: MultiSliver(
              children: [
                Text(
                  "Explore tools",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22),
                SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveBreakPoints.isMobile(context)
                        ? 2
                        : 6,
                    childAspectRatio: 2.8,
                  ),
                  itemCount: essentialItems.length,
                  itemBuilder: (context, index) => EssentialCategoryTile(
                    title: essentialItems[index].title,
                    iconWidget: Image.asset(
                      essentialItems[index].iconPath,
                      height: 32,
                    ),
                    onTap: essentialItems[index].ontap,
                    position: index,
                    crossAxisCount: 2,
                    totalItems: essentialItems.length,
                  ),
                ),
                SizedBox(height: 22),
                BannerAdWidget(size: AdSize.fullBanner),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
