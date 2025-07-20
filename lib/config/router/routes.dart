import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Main pages
@TypedShellRoute<MainLayoutShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<CalendarRoute>(path: '/calendar'),
    TypedGoRoute<EssentialsRoute>(path: '/essentials'),
    TypedGoRoute<MeteorRoute>(path: '/meteor'),
    TypedGoRoute<ProfileRoute>(
      path: '/profile',
      routes: [TypedGoRoute<CompleteProfileRoute>(path: "additional-info")],
    ),
  ],
)
class MainLayoutShellRoute extends ShellRouteData {
  const MainLayoutShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    // In the navigator, we get the current tab widget.
    return LayoutPage(child: navigator);
  }
}

class HomeRoute extends GoRouteData with _$HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Chirp"),
            FilledButton(
              onPressed: () => ShereheRoute().push(context),
              child: Text("Sherehe"),
            ),
          ],
        ),
      ),
    );
  }
}

class EssentialsRoute extends GoRouteData with _$EssentialsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text("Essentials")));
  }
}

class CalendarRoute extends GoRouteData with _$CalendarRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text("Your calendar")));
  }
}

class MeteorRoute extends GoRouteData with _$MeteorRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text("MeteorRoute")));
  }
}

@TypedGoRoute<AuthRoute>(path: "/auth")
class AuthRoute extends GoRouteData with _$AuthRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthScreen();
  }
}

@TypedGoRoute<ProfileRoute>(path: "/profile")
class ProfileRoute extends GoRouteData with _$ProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(appBar: AppBar(title: Text("Profile")));
  }
}

class CompleteProfileRoute extends GoRouteData with _$CompleteProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CompleteProfileScreen();
  }
}

@TypedGoRoute<ShereheRoute>(path: "/sherehe")
class ShereheRoute extends GoRouteData with _$ShereheRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheDetails();
  }
}
