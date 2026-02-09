import 'dart:io';
import 'package:academia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import '../widgets/tracking_explainer_sheet.dart';
import 'package:flutter/foundation.dart';

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
    widget.navigationShell.goBranch(index);
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
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !ResponsiveBreakPoints.isMobile(context),
              child: NavigationRail(
                selectedIconTheme: Theme.of(
                  context,
                ).iconTheme.copyWith(color: Theme.of(context).primaryColor),
                selectedLabelTextStyle: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
                labelType: NavigationRailLabelType.all,
                groupAlignment:
                    constraints.maxWidth > ResponsiveBreakPoints.tablet
                    ? 0.0
                    : null,
                onDestinationSelected: _onNavigationSelected,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Symbols.house),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Symbols.calendar_today),
                    label: Text("Calendar"),
                  ),

                  // NavigationRailDestination(
                  //   icon: Icon(Symbols.digital_wellbeing),
                  //   label: Text("Well Being"),
                  // ),
                  NavigationRailDestination(
                    icon: Icon(Symbols.grid_view),
                    label: Text("Essentials"),
                  ),
                ],
                selectedIndex: widget.navigationShell.currentIndex,
              ),
            ),
            Expanded(flex: 5, child: widget.navigationShell),
          ],
        ),
        bottomNavigationBar: !ResponsiveBreakPoints.isMobile(context)
            ? null
            : NavigationBar(
                onDestinationSelected: _onNavigationSelected,
                selectedIndex: widget.navigationShell.currentIndex,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Symbols.house),
                    selectedIcon: Icon(Symbols.house),
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: Icon(Symbols.calendar_today),
                    selectedIcon: Icon(Symbols.calendar_today),
                    label: "Calendar",
                  ),

                  // NavigationDestination(
                  //   icon: Icon(Symbols.digital_wellbeing),
                  //   label: "Well Being",
                  // ),
                  NavigationDestination(
                    icon: Icon(Symbols.grid_view),
                    selectedIcon: Icon(Symbols.grid_view),
                    label: "Essentials",
                  ),
                ],
              ),
      ),
    );
  }
}
