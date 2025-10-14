import 'package:academia/core/core.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

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

class HomeRoute extends GoRouteData with _$HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

class EssentialsRoute extends GoRouteData with _$EssentialsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EssentialsPage();
  }
}

class CalendarRoute extends GoRouteData with _$CalendarRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AgendaHomePage();
  }
}

class AgendaItemViewRoute extends GoRouteData with _$AgendaItemViewRoute {
  AgendaItemViewRoute({this.id});
  String? id;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: AgendaItemViewPage(agendaEventID: id),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

class CreateAgendaEventRoute extends GoRouteData with _$CreateAgendaEventRoute {
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: const CreateAgendaEventPage(),
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

// class MeteorRoute extends GoRouteData with _$MeteorRoute {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return Scaffold(body: Center(child: Text("MeteorRoute")));
//   }
// }

@TypedGoRoute<FeedRoute>(path: "/feed")
class FeedRoute extends GoRouteData with _$FeedRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FeedPage();
  }
}

@TypedGoRoute<PostDetailRoute>(path: '/post/:postId')
class PostDetailRoute extends GoRouteData with _$PostDetailRoute {
  final int postId;

  const PostDetailRoute({required this.postId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final post = state.extra as Post;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostCubit(post)),
        BlocProvider(
          create: (context) =>
              sl.get<ChirpUserCubit>()..getChirpUserByID(post.authorId),
        ),
      ],
      child: PostDetailPage(post: post),
    );
  }
}

@TypedGoRoute<AddPostRoute>(path: "/add-post")
class AddPostRoute extends GoRouteData with _$AddPostRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AddPostPage();
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
  routes: [
    TypedGoRoute<ShereheDetailsRoute>(path: "get-event"),
    TypedGoRoute<CreateEventRoute>(path: "create"),
  ],
)
class ShereheRoute extends GoRouteData with _$ShereheRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheHome();
  }
}

class CreateEventRoute extends GoRouteData with _$CreateEventRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateEventScreen();
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

@TypedGoRoute<TodosRoute>(
  path: "/todos",
  // routes: [TypedGoRoute<TodoRoute>(path: "get-event")],
)
class TodosRoute extends GoRouteData with _$TodosRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodoHomeScreen();
  }
}

@TypedGoRoute<MagnetRoute>(
  path: "/magnet",
  routes: [
    TypedGoRoute<MagnetAuthRoute>(path: "auth/:institutionID"),
    TypedGoRoute<MagnetHomeRoute>(
      path: ":institutionID",
      routes: [
        TypedGoRoute<MagnetProfileRoute>(path: "profile"),
        TypedGoRoute<MagnetCoursesRoute>(path: "courses"),
        TypedGoRoute<MagnetFeesRoute>(path: "fees"),
      ],
    ),
  ],
)
class MagnetRoute extends GoRouteData with _$MagnetRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text("Magnet route")));
  }
}

class MagnetAuthRoute extends GoRouteData with _$MagnetAuthRoute {
  final int institutionID;
  MagnetAuthRoute({required this.institutionID});
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MagnetAuthScreen(institutionID: institutionID),
      transitionDuration: Duration(milliseconds: 600),
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
            ).chain(CurveTween(curve: Curves.easeInOutCubic));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

@TypedGoRoute<CommunitiesRoute>(
  path: "/communities/:communityId",
  routes: [
    TypedGoRoute<CommunityInfoRoute>(path: 'info'),
    TypedGoRoute<CommunityMembersRoute>(path: "members/:role"),
    TypedGoRoute<EditCommunityInfoRoute>(path: "edit"),
  ],
)
class CommunitiesRoute extends GoRouteData with _$CommunitiesRoute {
  final int communityId;

  CommunitiesRoute({required this.communityId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityHome(communityId: communityId);
  }
}

class CommunityInfoRoute extends GoRouteData with _$CommunityInfoRoute {
  final int communityId;
  CommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityInfoPage(communityId: communityId);
  }
}

class CommunityMembersRoute extends GoRouteData with _$CommunityMembersRoute {
  final int communityId;
  final String role;

  CommunityMembersRoute({required this.communityId, required this.role});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembersPage(communityID: communityId, role: role);
  }
}

class EditCommunityInfoRoute extends GoRouteData with _$EditCommunityInfoRoute {
  final int communityId;
  EditCommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditCommunityInformation(communityID: communityId);
  }
}

@TypedGoRoute<CreateCommunitiesRoute>(path: "/create-community")
class CreateCommunitiesRoute extends GoRouteData with _$CreateCommunitiesRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateCommunityScreen();
  }
}

class MagnetProfileRoute extends GoRouteData with _$MagnetProfileRoute {
  final int institutionID;
  MagnetProfileRoute({required this.institutionID});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MagnetProfilePage(institutionID: institutionID);
  }
}

class MagnetCoursesRoute extends GoRouteData with _$MagnetCoursesRoute {
  final int institutionID;
  MagnetCoursesRoute({required this.institutionID});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MagnetCoursesScreen(institutionID: institutionID);
  }
}

class MagnetFeesRoute extends GoRouteData with _$MagnetFeesRoute {
  final int institutionID;
  MagnetFeesRoute({required this.institutionID});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MagnetFeesTransactionsPage(institutionID: institutionID);
  }
}

class MagnetHomeRoute extends GoRouteData with _$MagnetHomeRoute {
  final int institutionID;
  MagnetHomeRoute({required this.institutionID});
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MagnetHomeScreen(institutionID: institutionID),
      transitionDuration: Duration(milliseconds: 600),
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
            ).chain(CurveTween(curve: Curves.easeInOutCubic));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

@TypedGoRoute<TrimVideoRoute>(path: "/video-trimer/:videoPath")
class TrimVideoRoute extends GoRouteData with _$TrimVideoRoute {
  TrimVideoRoute({required this.videoPath});
  final String videoPath;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VideoTrimmerPage(videoPath: videoPath);
  }
}

@TypedGoRoute<CommunityMembershipsRoute>(path: "/community/memberships/mine")
class CommunityMembershipsRoute extends GoRouteData
    with _$CommunityMembershipsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembershipPage();
  }
}
