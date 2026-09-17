import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permissions/src/presentation/screens/notification_permission_screen.dart';

part 'notification_permission_routes.g.dart';

@TypedGoRoute<NotificationPermissionRoute>(path: '/notification-allow')
class NotificationPermissionRoute extends GoRouteData
    with $NotificationPermissionRoute {
  const NotificationPermissionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationPermissionScreen();
  }
}
