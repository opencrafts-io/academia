import 'package:academia/config/router/router.dart';
import 'package:academia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
                    icon: Icon(FontAwesome.house_solid),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesome.calendar_day_solid),
                    label: Text("Agenda"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(FontAwesome.meteor_solid),
                    label: Text("Assitant"),
                  ),

                  NavigationRailDestination(
                    icon: Icon(FontAwesome.rocket_solid),
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
                    icon: Icon(FontAwesome.house_solid),
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: Icon(FontAwesome.calendar_day_solid),
                    label: "Agenda",
                  ),
                  NavigationDestination(
                    icon: Icon(FontAwesome.meteor_solid),
                    label: "Assitant",
                  ),

                  NavigationDestination(
                    icon: Icon(FontAwesome.rocket_solid),
                    label: "Essentials",
                  ),
                ],
              ),
      ),
    );
  }
}
