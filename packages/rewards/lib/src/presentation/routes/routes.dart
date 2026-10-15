export 'rewards_routes.dart'
    show
        AchievementsHomePageRoute,
        AchievementDetailPageRoute,
        ActivitiesPageRoute;

import 'package:go_router/go_router.dart';

import 'rewards_routes.dart';

final List<RouteBase> routes = [
  ...$appRoutes,
  GoRoute(path: '/rewards', redirect: (context, state) => '/achievements'),
];
