import 'package:academia/config/router/router.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:academia/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.child});

  final Widget child;
  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int selectedIndex = 0;

  void _onNavigationSelected(int index) {
    switch (index) {
      case 0:
        HomeRoute().go(context);
      case 1:
        CalendarRoute().go(context);
      case 2:
        MeteorRoute().go(context);
      case 3:
        EssentialsRoute().go(context);
      case 4:
        FeedRoute().go(context);
    }
    selectedIndex = index;
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
                    label: Text("Agenda"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Symbols.digital_wellbeing),
                    label: Text("Well Being"),
                  ),

                  NavigationRailDestination(
                    icon: Icon(Symbols.grid_view),
                    label: Text("Essentials"),
                  ),
                ],
                selectedIndex: selectedIndex,
              ),
            ),
            Expanded(flex: 5, child: widget.child),
          ],
        ),
        bottomNavigationBar: !ResponsiveBreakPoints.isMobile(context)
            ? null
            : NavigationBar(
                onDestinationSelected: _onNavigationSelected,
                selectedIndex: selectedIndex,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Symbols.house),
                    selectedIcon: Icon(Symbols.house),
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: Icon(Symbols.calendar_today),
                    selectedIcon: Icon(Symbols.calendar_today),
                    label: "Agenda",
                  ),
                  NavigationDestination(
                    icon: Icon(Symbols.digital_wellbeing),
                    label: "Well Being",
                  ),

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
