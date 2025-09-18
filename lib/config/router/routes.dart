import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Added import for Bloc
import 'package:academia/features/features.dart';

import 'package:academia/injection_container.dart';

import '../../features/sherehe/domain/usecases/create_event_use_case.dart'; // Assuming your service locator (sl) is here

part 'routes.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Main pages
@TypedShellRoute<MainLayoutShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<CalendarRoute>(
      path: '/calendar',
      routes: [
        TypedGoRoute<CreateAgendaEventRoute>(path: "create"),
        TypedGoRoute<AgendaItemViewRoute>(path: "item/:id"),
      ],
    ),
    TypedGoRoute<EssentialsRoute>(path: '/essentials'),
    TypedGoRoute<MeteorRoute>(path: '/meteor'),
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

class MeteorRoute extends GoRouteData with _$MeteorRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text("MeteorRoute")));
  }
}

@TypedGoRoute<FeedRoute>(path: "/feed")
class FeedRoute extends GoRouteData with _$FeedRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FeedPage();
  }
}

@TypedGoRoute<ChatRoute>(path: "/chat/:conversationId")
class ChatRoute extends GoRouteData with _$ChatRoute {
  final String conversationId;

  const ChatRoute({required this.conversationId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChatPage(conversationId: conversationId);
  }
}

@TypedGoRoute<PostDetailRoute>(path: '/post/:postId')
class PostDetailRoute extends GoRouteData with _$PostDetailRoute {
  final String postId;

  const PostDetailRoute({required this.postId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final post = state.extra as Post;
    return PostDetailPage(post: post);
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
    return BlocProvider<CreateEventBloc>(
      create: (context) =>
          CreateEventBloc(createEventUseCase: sl<CreateEventUseCase>()),
      child: const CreateEventScreen(),
    );
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
    TypedGoRoute<CommunityUserListRoute>(path: "users"),
    TypedGoRoute<AddMembersRoute>(path: "add-members"),
  ],
)
class CommunitiesRoute extends GoRouteData with _$CommunitiesRoute {
  final String communityId;

  CommunitiesRoute({required this.communityId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityHome(communityId: communityId);
  }
}

class CommunityUserListRoute extends GoRouteData with _$CommunityUserListRoute {
  final String communityId;
  final String userId;
  final String title;
  final bool isTargetModerator;
  final bool isTargetBannedUsers;
  final bool isTargetMember;
  final bool isCreator;
  final bool isModerator;
  final bool isMember;
  final bool isBanned;
  final bool isPrivate;

  const CommunityUserListRoute({
    required this.communityId,
    required this.userId,
    required this.title,
    this.isTargetModerator = false,
    this.isTargetBannedUsers = false,
    this.isTargetMember = false,
    this.isCreator = false,
    this.isModerator = false,
    this.isMember = false,
    this.isBanned = false,
    this.isPrivate = false,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final users = state.extra as List<Map<String, String>>;
    return CommunityUserListScreen(
      communityId: communityId,
      userId: userId,
      title: title,
      users: users,
      isTargetModerator: isTargetModerator,
      isTargetBannedUsers: isTargetBannedUsers,
      isTargetMembers: isTargetMember,
      isCreator: isCreator,
      isModerator: isModerator,
      isMember: isMember,
      isBanned: isBanned,
      isPrivate: isPrivate,
    );
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

class AddMembersRoute extends GoRouteData with _$AddMembersRoute {
  final String communityId;
  final String userId;

  AddMembersRoute({required this.communityId, required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddMembersScreen(communityId: communityId, userId: userId);
  }
}

@TypedGoRoute<CreateCommunitiesRoute>(path: "/create-community")
class CreateCommunitiesRoute extends GoRouteData with _$CreateCommunitiesRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateCommunityScreen();
  }
}
