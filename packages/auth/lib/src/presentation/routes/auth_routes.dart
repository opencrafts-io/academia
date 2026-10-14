import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/auth_screen.dart';

class AuthRoute {
  const AuthRoute();

  String get location => '/auth';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

List<RouteBase> get routes => [
  GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
];
