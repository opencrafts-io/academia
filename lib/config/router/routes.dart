import 'package:academia/core/core.dart';
import 'package:academia/core/integration/splash_launch_page.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:academia/core/integration/agenda_calendar/agenda_home_page.dart';
import 'package:agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:lock_in/lock_in.dart';
import 'package:courses/courses.dart' as courses_package;

export 'package:rewards/rewards.dart'
    show
        AchievementsHomePageRoute,
        AchievementDetailPageRoute,
        ActivitiesPageRoute;

part 'routes.g.dart';
part 'routes/feed_routes.dart';
part 'routes/auth_routes.dart';
part 'routes/sherehe_routes.dart';
part 'routes/community_routes.dart';
part 'routes/academic_routes.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<SplashScreenRoute>(path: "/splash")
class SplashScreenRoute extends GoRouteData with $SplashScreenRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashLaunchPage();
  }
}

@TypedStatefulShellRoute<LayoutShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/')]),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<CalendarRoute>(
          path: '/calendar',
          routes: [
            TypedGoRoute<CreateAgendaEventRoute>(path: 'create'),
            TypedGoRoute<AgendaItemViewRoute>(path: 'item/:id'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<EssentialsRoute>(path: '/essentials')],
    ),
  ],
)
class LayoutShellRoute extends StatefulShellRouteData {
  const LayoutShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return LayoutPage(navigationShell: navigationShell);
  }
}

class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

class EssentialsRoute extends GoRouteData with $EssentialsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EssentialsPage();
  }
}

@TypedGoRoute<LockInRoute>(path: '/lock-in')
class LockInRoute extends GoRouteData with $LockInRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LockInPage(service: sl<LockInService>());
  }
}

class CalendarRoute extends GoRouteData with $CalendarRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AgendaHomePage();
  }
}

class AgendaItemViewRoute extends GoRouteData with $AgendaItemViewRoute {
  AgendaItemViewRoute({this.id});
  String? id;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _agendaSheetPage(
      context,
      state,
      AgendaItemViewPage(agendaEventID: id),
    );
  }
}

class CreateAgendaEventRoute extends GoRouteData with $CreateAgendaEventRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    return _agendaSheetPage(
      context,
      state,
      CreateAgendaEventPage(
        event: extra is AgendaEvent ? extra : null,
        initialDate: extra is DateTime ? extra : null,
      ),
    );
  }
}

Page<void> _agendaSheetPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return ModalSheetPage(
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
    child: SheetKeyboardDismissible(
      dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
        isContentScrollAware: true,
      ),
      child: Sheet(
        scrollConfiguration: const SheetScrollConfiguration(),
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        decoration: const MaterialSheetDecoration(
          size: SheetSize.fit,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
        physics: BouncingSheetPhysics(),
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight * 0.94,
            ),
            child: child,
          ),
        ),
      ),
    ),
  );
}

// class MeteorRoute extends GoRouteData with $MeteorRoute {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return Scaffold(body: Center(child: Text("MeteorRoute")));
//   }
// }
