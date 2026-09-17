import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/src/presentation/views/settings_page.dart';

part 'settings_routes.g.dart';

@TypedGoRoute<SettingsPageRoute>(path: '/settings')
class SettingsPageRoute extends GoRouteData with $SettingsPageRoute {
  const SettingsPageRoute();

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const SettingsPage(),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final offsetAnimation = animation.drive(
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOutQuad)),
            );

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}
