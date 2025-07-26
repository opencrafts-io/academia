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
    return HomePage();
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
    return AgendaHomePage();
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
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const ProfileView(),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

@TypedGoRoute<CompleteProfileRoute>(path: "/complete-profile")
class CompleteProfileRoute extends GoRouteData with _$CompleteProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CompleteProfileScreen();
  }
}

@TypedGoRoute<ShereheRoute>(
  path: "/sherehe",
  routes: [TypedGoRoute<ShereheDetailsRoute>(path: "get-event")],
)
class ShereheRoute extends GoRouteData with _$ShereheRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheHome();
  }
}

class ShereheDetailsRoute extends GoRouteData with _$ShereheDetailsRoute {
  final String eventId;

  const ShereheDetailsRoute({required this.eventId});

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ShereheDetailsPage(eventId: eventId),

      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(
              begin: Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}
