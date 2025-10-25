import 'package:academia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  void _onNavigationSelected(int index) {
    widget.navigationShell.goBranch(index);
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
