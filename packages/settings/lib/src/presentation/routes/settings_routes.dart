import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/src/presentation/cubit/notification_preferences_cubit.dart';
import 'package:settings/src/presentation/views/notification_settings_page.dart';
import 'package:settings/src/presentation/views/settings_page.dart';

part 'settings_routes.g.dart';

@TypedGoRoute<SettingsPageRoute>(
  path: '/settings',
  routes: [TypedGoRoute<NotificationSettingsRoute>(path: 'notifications')],
)
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

class NotificationSettingsRoute extends GoRouteData
    with $NotificationSettingsRoute {
  const NotificationSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider(
    create: (_) => GetIt.I<NotificationPreferencesCubit>()..refresh(),
    child: const NotificationSettingsPage(),
  );
}
