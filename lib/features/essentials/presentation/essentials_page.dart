import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:ads/ads.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings/settings.dart';
import 'package:sliver_tools/sliver_tools.dart';
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
    final institutions = institutionState.whenOrNull(
      loaded: (institutions) => institutions,
    );

    if (institutions != null && institutions.isNotEmpty) {
      final primaryInstitution = institutions.first;

      final result = await sl<FetchInstitutionScrappingCommandUsecase>()(
        primaryInstitution.institutionId,
      );

      final isSupported = result.fold(
        (failure) => false,
        (command) => command != null,
      );

      if (!mounted) return;

      if (isSupported) {
        final adService = sl<AdService>();
        adService.showInterstitialAd();
        if (!mounted) return;
        ExamTimetableRoute(institutionId: primaryInstitution.institutionId)
            .push(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature is not supported for your school"),
          ),
        );
      }
    } else {
      const LinkInstitutionRequiredPageRoute().push(context);
    }
  }

  /// A compact two-column tool grid that keeps every destination equally easy
  /// to scan, regardless of the screen width.
  Widget _buildToolsGrid(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const columnCount = 2;
    const cornerRadius = Radius.circular(8);
    final lastRow = (essentialItems.length - 1) ~/ columnCount;

    Widget tile(int index) {
      final item = essentialItems[index];
      final row = index ~/ columnCount;
      final column = index % columnCount;

      return EssentialCategoryTile(
        title: item.title,
        iconPath: item.iconPath,
        onTap: item.ontap,
        color: colorScheme.surfaceContainerHigh,
        onColor: colorScheme.onSurface,
        borderRadius: BorderRadius.only(
          topLeft: row == 0 && column == 0 ? cornerRadius : Radius.zero,
          topRight: row == 0 && column == columnCount - 1
              ? cornerRadius
              : Radius.zero,
          bottomLeft: row == lastRow && column == 0
              ? cornerRadius
              : Radius.zero,
          bottomRight: row == lastRow && column == columnCount - 1
              ? cornerRadius
              : Radius.zero,
        ),
      );
    }

    return GridView.builder(
      padding: .symmetric(vertical: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: essentialItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        mainAxisExtent: 64,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) => tile(index),
    );
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
                      "Essentials",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Assets.icons.animalsIconButterfly.image(
                      height: 40,
                      width: 40,
                    ),
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
                Card.filled(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      child: Icon(
                        Icons.settings_rounded,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text("Settings & Preferences"),
                    subtitle: Text("Make Academia behave how you like"),
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    onTap: () => SettingsPageRoute().push(context),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 12),
                Card.filled(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Icon(
                      Icons.lock_clock_rounded,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    title: const Text('Lock In'),
                    subtitle: const Text(
                      'Block distracting apps during focus time',
                    ),
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    onTap: () => LockInRoute().push(context),
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  "Explore tools",
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _buildToolsGrid(context),
                SizedBox(height: 22),
                BannerAdWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
