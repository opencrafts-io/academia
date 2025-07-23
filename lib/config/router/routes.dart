import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/chirp/chirp.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Main pages
@TypedShellRoute<MainLayoutShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<CalendarRoute>(path: '/calendar'),
    TypedGoRoute<EssentialsRoute>(path: '/essentials'),
    TypedGoRoute<MeteorRoute>(path: '/meteor'),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
    TypedGoRoute<ConversationsRoute>(path: '/conversations'),
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
    return Scaffold(body: Center(child: Text("Chirp")));
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

@TypedGoRoute<CompleteProfileRoute>(path: "/complete-profile")
class CompleteProfileRoute extends GoRouteData with _$CompleteProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CompleteProfileScreen();
  }
}

@TypedGoRoute<ConversationsRoute>(path: "/conversations")
class ConversationsRoute extends GoRouteData with _$ConversationsRoute {
  const ConversationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ConversationsPage();
  }
}

@TypedGoRoute<ChatRoute>(path: "/chat/:id")
class ChatRoute extends GoRouteData with _$ChatRoute {
  const ChatRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final conversation = state.extra as Conversation?;
    return ChatPage(conversationId: id, conversation: conversation);
  }
}
