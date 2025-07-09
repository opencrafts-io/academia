import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(path: "/")
class HomeRoute extends GoRouteData with _$HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthScreen();
  }
}
