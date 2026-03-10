import 'dart:io';
import 'package:academia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import '../widgets/tracking_explainer_sheet.dart';
import 'package:flutter/foundation.dart';


class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.navigationShell,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Symbols.house_rounded),
            selectedIcon: Icon(Symbols.house_rounded, fill: 1),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Symbols.calendar_today_rounded),
            selectedIcon: Icon(Symbols.calendar_today_rounded, fill: 1),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Symbols.grid_view_rounded),
            selectedIcon: Icon(Symbols.grid_view_rounded, fill: 1),
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
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            selectedLabelTextStyle: Theme.of(context)
                .textTheme
                .labelMedium
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
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.navigationShell,
    required this.onDestinationSelected,
    required this.selectedIndex,
    this.isLarge = false,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showExpressiveTrackingSheet(context);
    });
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

    if (ResponsiveBreakPoints.isMobile(context)) {
      return _MobileLayout(
        navigationShell: widget.navigationShell,
        onDestinationSelected: _onNavigationSelected,
        selectedIndex: selectedIndex,
      );
    }

    if (ResponsiveBreakPoints.isTablet(context)) {
      return _TabletLayout(
        navigationShell: widget.navigationShell,
        onDestinationSelected: _onNavigationSelected,
        selectedIndex: selectedIndex,
      );
    }

    return _DesktopLayout(
      navigationShell: widget.navigationShell,
      onDestinationSelected: _onNavigationSelected,
      selectedIndex: selectedIndex,
      isLarge: ResponsiveBreakPoints.isLargeDesktop(context),
    );
  }
}