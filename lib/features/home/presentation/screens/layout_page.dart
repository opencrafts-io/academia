import 'dart:async';
import 'dart:io';

import 'package:academia/constants/constants.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:study_tools/study_tools.dart' as study_tools;

import '../widgets/tracking_explainer_sheet.dart';

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.navigationShell,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.podcastHandler,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final study_tools.PodcastAudioHandler? podcastHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: study_tools.PodcastNowPlayingOverlay(
        handler: podcastHandler,
        child: navigationShell,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: Assets.icons.house.image(height: 40),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/icons/calendar.png',
              package: 'agenda',
              height: 40,
            ),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Assets.icons.calculator.image(height: 40),
            label: 'Essentials',
          ),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout({
    required this.navigationShell,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.podcastHandler,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final study_tools.PodcastAudioHandler? podcastHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: study_tools.PodcastNowPlayingOverlay(
        handler: podcastHandler,
        bottomInset: MediaQuery.viewPaddingOf(context).bottom,
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              selectedLabelTextStyle: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Symbols.house_rounded),
                  selectedIcon: Icon(Symbols.house_rounded, fill: 1),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Symbols.calendar_today_rounded),
                  selectedIcon: Icon(Symbols.calendar_today_rounded, fill: 1),
                  label: Text('Calendar'),
                ),
                NavigationRailDestination(
                  icon: Icon(Symbols.grid_view_rounded),
                  selectedIcon: Icon(Symbols.grid_view_rounded, fill: 1),
                  label: Text('Essentials'),
                ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.navigationShell,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.podcastHandler,
    this.isLarge = false,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final study_tools.PodcastAudioHandler? podcastHandler;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: study_tools.PodcastNowPlayingOverlay(
        handler: podcastHandler,
        bottomInset: MediaQuery.viewPaddingOf(context).bottom,
        child: Row(
          children: [
            NavigationDrawer(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(28, isLarge ? 24 : 16, 16, 10),
                  child: Text(
                    'Academia',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Symbols.house),
                  selectedIcon: Icon(Symbols.house_rounded, fill: 1),
                  label: Text('Home'),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Symbols.calendar_today_rounded),
                  selectedIcon: Icon(Symbols.calendar_today_rounded, fill: 1),
                  label: Text('Calendar'),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Symbols.grid_view_rounded),
                  selectedIcon: Icon(Symbols.grid_view_rounded, fill: 1),
                  label: Text('Essentials'),
                ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool _podcastAudioHandlerReady = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initializePodcastAudioHandler());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showExpressiveTrackingSheet(context);
    });
  }

  Future<void> _initializePodcastAudioHandler() async {
    try {
      await sl.isReady<study_tools.PodcastAudioHandler>();
      if (mounted) setState(() => _podcastAudioHandlerReady = true);
    } catch (error, stackTrace) {
      debugPrint(
        'Podcast audio startup initialization failed: $error\n$stackTrace',
      );
    }
  }

  void _onNavigationSelected(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<void> showExpressiveTrackingSheet(BuildContext context) async {
    if (kIsWeb && !Platform.isIOS) return;
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;

    if (status == TrackingStatus.notDetermined && context.mounted) {
      await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        builder: (context) => const TrackingExplainerSheet(),
      );

      await Future.delayed(const Duration(milliseconds: 400));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.navigationShell.currentIndex;
    final podcastHandler = _podcastAudioHandlerReady
        ? sl<study_tools.PodcastAudioHandler>()
        : null;

    if (ResponsiveBreakPoints.isMobile(context)) {
      return _MobileLayout(
        navigationShell: widget.navigationShell,
        onDestinationSelected: _onNavigationSelected,
        selectedIndex: selectedIndex,
        podcastHandler: podcastHandler,
      );
    }

    if (ResponsiveBreakPoints.isTablet(context)) {
      return _TabletLayout(
        navigationShell: widget.navigationShell,
        onDestinationSelected: _onNavigationSelected,
        selectedIndex: selectedIndex,
        podcastHandler: podcastHandler,
      );
    }

    return _DesktopLayout(
      navigationShell: widget.navigationShell,
      onDestinationSelected: _onNavigationSelected,
      selectedIndex: selectedIndex,
      podcastHandler: podcastHandler,
      isLarge: ResponsiveBreakPoints.isLargeDesktop(context),
    );
  }
}
