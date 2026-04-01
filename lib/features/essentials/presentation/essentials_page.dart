import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:academia/injection_container.dart';
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
      title: "Semesters",
      ontap: () {
        SemestersPageRoute().push(context);
      },
      iconPath: Assets.icons.calendar.keyName,
    ),
    _EssentialItem(
      title: "Courses",
      ontap: () => CoursesPageRoute().push(context),
      iconPath: Assets.icons.book.keyName,
    ),
    _EssentialItem(
      title: "To-Dos",
      ontap: () => TodosRoute().push(context),
      iconPath: Assets.icons.notificationIconBell.keyName,
    ),

    _EssentialItem(
      title: "Exam timetable",
      ontap: _navigateToExamTimetable,
      iconPath: Assets.icons.document.keyName,
    ),
  ];

  void _navigateToExamTimetable() async {
    final institutionState = context.read<InstitutionBloc>().state;

    if (institutionState is InstitutionLoadedState &&
        institutionState.institutions.isNotEmpty) {
      final primaryInstitution = institutionState.institutions.first;

      context.read<ScrappingCommandBloc>().add(
        GetScrappingCommandEvent(
          institutionID: primaryInstitution.institutionId,
        ),
      );
      final resolvedState = await context
          .read<ScrappingCommandBloc>()
          .stream
          .firstWhere((s) => s is! ScrappingCommandLoading);

      final isSupported =
          resolvedState is ScrappingCommandLoaded &&
          resolvedState.command != null;

      if (!mounted) return;

      if (isSupported) {
        final adService = sl<AdService>();
        adService.showInterstitialAd();
        if (!mounted) return;
        ExamTimetableRoute(
          institutionId: primaryInstitution.institutionId.toString(),
        ).push(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature is not supported for your school"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No institution data found")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Essentials ",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
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

          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(child: EssentialsInstitutionSection()),
          ),
          // Academia's tools
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            sliver: MultiSliver(
              children: [
                Card.outlined(
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings & Preferences"),
                    subtitle: Text("Make Academia behave how you like"),
                    onTap: () => SettingsPageRoute().push(context),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
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
                BannerAdWidget(size: AdSize.banner),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
