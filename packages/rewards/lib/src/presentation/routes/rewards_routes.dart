import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../reward_details_page.dart';
import '../rewards_home_page.dart';

part 'rewards_routes.g.dart';

@TypedGoRoute<AchievementsHomePageRoute>(
  path: '/achievements',
  routes: [TypedGoRoute<AchievementDetailPageRoute>(path: ':id')],
)
class AchievementsHomePageRoute extends GoRouteData
    with $AchievementsHomePageRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _rewardsSheetPage(context, state, const RewardsHomePage());
}

@TypedGoRoute<ActivitiesPageRoute>(path: '/activities/:id')
class ActivitiesPageRoute extends GoRouteData with $ActivitiesPageRoute {
  const ActivitiesPageRoute({required this.id});

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _rewardsSheetPage(
        context,
        state,
        RewardDetailsPage(id: id, isActivity: true),
      );
}

class AchievementDetailPageRoute extends GoRouteData
    with $AchievementDetailPageRoute {
  const AchievementDetailPageRoute({required this.id});

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _rewardsSheetPage(context, state, RewardDetailsPage(id: id));
}

Page<void> _rewardsSheetPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) => ModalSheetPage(
  key: state.pageKey,
  swipeDismissible: true,
  transitionCurve: Curves.easeOutCubic,
  viewportBuilder: (context, child) => SheetViewport(
    padding: EdgeInsets.only(
      top: MediaQuery.viewPaddingOf(context).top,
      bottom: MediaQuery.viewPaddingOf(context).bottom,
    ),
    child: child,
  ),
  child: Sheet(
    scrollConfiguration: const SheetScrollConfiguration(),
    decoration: const MaterialSheetDecoration(
      size: SheetSize.fit,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
    ),
    physics: BouncingSheetPhysics(),
    child: LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: constraints.maxHeight * .94),
        child: child,
      ),
    ),
  ),
);
