import 'package:academia/core/core.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

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

class CalendarRoute extends GoRouteData with $CalendarRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AgendaHomePage();
  }
}

class AgendaItemViewRoute extends GoRouteData with $AgendaItemViewRoute {
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

class CreateAgendaEventRoute extends GoRouteData with $CreateAgendaEventRoute {
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

// class MeteorRoute extends GoRouteData with $MeteorRoute {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return Scaffold(body: Center(child: Text("MeteorRoute")));
//   }
// }

@TypedGoRoute<FeedRoute>(path: "/feed")
class FeedRoute extends GoRouteData with $FeedRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FeedPage();
  }
}

@TypedGoRoute<PostDetailRoute>(path: '/post/:postId')
class PostDetailRoute extends GoRouteData with $PostDetailRoute {
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
class AddPostRoute extends GoRouteData with $AddPostRoute {
  const AddPostRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final community = state.extra as Community?;
    return AddPostPage(preselectedCommunity: community);
  }
}

@TypedGoRoute<BlockedItemsRoute>(path: "/blocked-items")
class BlockedItemsRoute extends GoRouteData with $BlockedItemsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BlockedItemsPage();
  }
}

@TypedGoRoute<AuthRoute>(path: "/auth")
class AuthRoute extends GoRouteData with $AuthRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AuthScreen();
  }
}

@TypedGoRoute<ProfileRoute>(path: "/profile")
class ProfileRoute extends GoRouteData with $ProfileRoute {
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
class CompleteProfileRoute extends GoRouteData with $CompleteProfileRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CompleteProfileScreen();
  }
}

@TypedGoRoute<ShereheRoute>(
  path: "/sherehe",
  routes: [
    TypedGoRoute<ShereheDetailsRoute>(
      path: "get-event/:eventId",
      routes: [
        TypedGoRoute<TicketFlowRoute>(path: "ticket-flow"),
        TypedGoRoute<QrCodeScannerRoute>(path: "qr-code-scanner"),
        TypedGoRoute<EventTicketsRoute>(path: "event-tickets"),
        TypedGoRoute<OrganizerDashboardRoute>(
          path: "organizer-dashboard",
          routes: [
            TypedGoRoute<AllAttendeesRoute>(path: "all-attendees"),
            TypedGoRoute<AllScannersRoute>(path: "all-scanners"),
            TypedGoRoute<AddEventScannerRoute>(path: "add-event-scanner"),
          ],
        ),
      ],
    ),
    TypedGoRoute<CreateEventRoute>(path: "create"),
  ],
)
class ShereheRoute extends GoRouteData with $ShereheRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShereheHome();
  }
}

class CreateEventRoute extends GoRouteData with $CreateEventRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateEventScreen();
  }
}

class ShereheDetailsRoute extends GoRouteData with $ShereheDetailsRoute {
  final String eventId;

  const ShereheDetailsRoute({required this.eventId});

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    final event = state.extra is Event ? state.extra as Event : null;

    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: ShereheDetailsPage(eventId: eventId, event: event),

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

class TicketFlowRoute extends GoRouteData with $TicketFlowRoute {
  final String eventId;
  final String userId;

  const TicketFlowRoute({required this.eventId, required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketFlowPage(eventId: eventId, userId: userId);
  }
}

class EventTicketsRoute extends GoRouteData with $EventTicketsRoute {
  final String eventId;

  const EventTicketsRoute({required this.eventId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final event = state.extra as Event;

    return EventTicketsPage(eventId: eventId, event: event);
  }
}

class OrganizerDashboardRoute extends GoRouteData
    with $OrganizerDashboardRoute {
  final String eventId;

  const OrganizerDashboardRoute({required this.eventId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrganizerDashboardPage(eventId: eventId);
  }
}

class AllAttendeesRoute extends GoRouteData with $AllAttendeesRoute {
  final String eventId;

  const AllAttendeesRoute({required this.eventId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AllAttendeesScreen(eventId: eventId);
  }
}

class AllScannersRoute extends GoRouteData with $AllScannersRoute {
  final String eventId;

  const AllScannersRoute({required this.eventId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AllScannersScreen(eventId: eventId);
  }
}

class AddEventScannerRoute extends GoRouteData with $AddEventScannerRoute {
  final String eventId;

  const AddEventScannerRoute({required this.eventId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddEventScannerScreen(eventId: eventId);
  }
}

@TypedGoRoute<PurchasedTicketsRoute>(path: "/purchased-tickets/all")
class PurchasedTicketsRoute extends GoRouteData with $PurchasedTicketsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PurchasedTicketsPage();
  }
}

@TypedGoRoute<OrganizedEventsRoute>(path: "/organized-events/mine")
class OrganizedEventsRoute extends GoRouteData with $OrganizedEventsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OrganizedEventsScreen();
  }
}

@TypedGoRoute<TicketReceiptRoute>(path: "/ticket-receipt")
class TicketReceiptRoute extends GoRouteData with $TicketReceiptRoute {
  final int ticketPrice;
  final int quantity;

  const TicketReceiptRoute({required this.ticketPrice, required this.quantity});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TicketReceiptScreen(ticketPrice: ticketPrice, quantity: quantity);
  }
}

@TypedGoRoute<QrCodeRoute>(path: "/qr-code/:eventId/:attendeeId")
class QrCodeRoute extends GoRouteData with $QrCodeRoute {
  final String eventId;
  final String attendeeId;
  final String ticketName;
  final int quantity;

  const QrCodeRoute({
    required this.eventId,
    required this.attendeeId,
    required this.ticketName,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final event = state.extra as Event;

    return QrCodeScreen(
      eventId: eventId,
      attendeeId: attendeeId,
      ticketName: ticketName,
      quantity: quantity,
      event: event,
    );
  }
}

class QrCodeScannerRoute extends GoRouteData with $QrCodeScannerRoute {
  final String eventId;

  const QrCodeScannerRoute({required this.eventId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QrCodeScannerScreen(eventId: eventId);
  }
}

@TypedGoRoute<TodosRoute>(
  path: "/todos",
  // routes: [TypedGoRoute<TodoRoute>(path: "get-event")],
)
class TodosRoute extends GoRouteData with $TodosRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodoHomeScreen();
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
class CommunitiesRoute extends GoRouteData with $CommunitiesRoute {
  final int communityId;

  CommunitiesRoute({required this.communityId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityHome(communityId: communityId);
  }
}

class CommunityInfoRoute extends GoRouteData with $CommunityInfoRoute {
  final int communityId;
  CommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityInfoPage(communityId: communityId);
  }
}

class CommunityMembersRoute extends GoRouteData with $CommunityMembersRoute {
  final int communityId;
  final String role;

  CommunityMembersRoute({required this.communityId, required this.role});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembersPage(communityID: communityId, role: role);
  }
}

class EditCommunityInfoRoute extends GoRouteData with $EditCommunityInfoRoute {
  final int communityId;
  EditCommunityInfoRoute({required this.communityId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditCommunityInformation(communityID: communityId);
  }
}

@TypedGoRoute<CreateCommunitiesRoute>(path: "/create-community")
class CreateCommunitiesRoute extends GoRouteData with $CreateCommunitiesRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateCommunityScreen();
  }
}

@TypedGoRoute<TrimVideoRoute>(path: "/video-trimer/:videoPath")
class TrimVideoRoute extends GoRouteData with $TrimVideoRoute {
  TrimVideoRoute({required this.videoPath});
  final String videoPath;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VideoTrimmerPage(videoPath: videoPath);
  }
}

@TypedGoRoute<CommunityMembershipsRoute>(path: "/community/memberships/mine")
class CommunityMembershipsRoute extends GoRouteData
    with $CommunityMembershipsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CommunityMembershipPage();
  }
}

@TypedGoRoute<AchievementsHomePageRoute>(
  path: "/achievements",
  routes: [TypedGoRoute<AchievementDetailPageRoute>(path: ":id")],
)
class AchievementsHomePageRoute extends GoRouteData
    with $AchievementsHomePageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AchievementsHomePage();
  }
}

@TypedGoRoute<ActivitiesPageRoute>(path: "/activities/:id")
class ActivitiesPageRoute extends GoRouteData with $ActivitiesPageRoute {
  final String id;
  const ActivitiesPageRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ActivityDetailPage(id: id);
  }
}

class AchievementDetailPageRoute extends GoRouteData
    with $AchievementDetailPageRoute {
  final String id;
  const AchievementDetailPageRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AchievementDetailPage(id: id);
  }
}

@TypedGoRoute<ExamTimetableRoute>(
  path: "/exam-timetable/:institutionId",
  routes: [TypedGoRoute<ExamTimetableSearchRoute>(path: "search")],
)
class ExamTimetableRoute extends GoRouteData with $ExamTimetableRoute {
  final String institutionId;

  const ExamTimetableRoute({required this.institutionId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExamTimetableHomeScreen(institutionId: institutionId);
  }
}

class ExamTimetableSearchRoute extends GoRouteData
    with $ExamTimetableSearchRoute {
  final String institutionId;

  const ExamTimetableSearchRoute({required this.institutionId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExamTimetableSearchScreen(institutionId: institutionId);
  }
}

@TypedGoRoute<SettingsPageRoute>(path: "/settings")
class SettingsPageRoute extends GoRouteData with $SettingsPageRoute {
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: SettingsPage(),
      transitionDuration: Duration(milliseconds: 300),
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
            ).chain(CurveTween(curve: Curves.easeInOutQuad));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

@TypedShellRoute<InstitutionShellRouteData>(
  routes: [
    TypedGoRoute<InstitutionHomePageRoute>(
      path: "/institution/:institutionID",
      routes: [
        TypedGoRoute<InstitutionKeysViewRoute>(path: "keys"),
        TypedGoRoute<InstitutionFeesTransactionRoute>(path: "fees"),
        TypedGoRoute<EditStudentProfileRoute>(path: "profile/:profileId"),
      ],
    ),
  ],
)
class InstitutionShellRouteData extends ShellRouteData {
  const InstitutionShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    // Extract institutionID from state if needed for initialization
    final institutionID = int.parse(state.pathParameters['institutionID']!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<ScrappingCommandBloc>()
                ..add(GetScrappingCommandEvent(institutionID: institutionID)),
        ),
        BlocProvider(
          create: (context) =>
              sl<InstitutionKeyBloc>()
                ..add(GetInstitutionKeyEvent(institutionID: institutionID)),
        ),
        BlocProvider(create: (context) => sl<MagnetBloc>()),
        BlocProvider(create: (context) => sl<StudentProfileBloc>()),
        BlocProvider(
          create: (context) =>
              sl<InstitutionFeesBloc>()..add(WatchFeesStarted(institutionID)),
        ),
      ],
      child: navigator, // This contains either the Home or Keys page
    );
  }
}

class InstitutionHomePageRoute extends GoRouteData
    with $InstitutionHomePageRoute {
  InstitutionHomePageRoute({required this.institutionID});

  final int institutionID;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: InstitutionHomePage(institutionID: institutionID),
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 1. Scale Tween: Starts slightly zoomed out
        final scaleTween = Tween<double>(
          begin: 0.92,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized));

        // 2. Fade Tween: Smoothly brings the opacity up
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
        );

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }
}

class InstitutionKeysViewRoute extends GoRouteData
    with $InstitutionKeysViewRoute {
  InstitutionKeysViewRoute({required this.institutionID});
  final int institutionID;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      swipeDismissible: true,
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: child,
      ),
      child: Sheet(child: InstitutionKeysView()),
    );
  }
}

class EditStudentProfileRoute extends GoRouteData
    with $EditStudentProfileRoute {
  final int profileId;
  final int? institutionID;
  const EditStudentProfileRoute({required this.profileId, this.institutionID});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditStudentProfilePage(profileId: profileId);
  }
}

class InstitutionFeesTransactionRoute extends GoRouteData
    with $InstitutionFeesTransactionRoute {
  InstitutionFeesTransactionRoute({required this.institutionID});

  final int institutionID;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InstitutionFeesTransactionPage();
  }
}

@TypedGoRoute<SemestersPageRoute>(
  path: "/semesters",
  routes: [
    TypedGoRoute<AddSemesterRoute>(path: "add"),
    TypedGoRoute<EditSemesterRoute>(path: "edit/:id"),
  ],
)
class SemestersPageRoute extends GoRouteData with $SemestersPageRoute {
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: SemestersPage(),
      transitionDuration: Duration(milliseconds: 300),
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
            ).chain(CurveTween(curve: Curves.easeInOutQuad));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

class AddSemesterRoute extends GoRouteData with $AddSemesterRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: child,
      ),
      child: Sheet(child: const AddSemesterSheet()),
    );
  }
}

class EditSemesterRoute extends GoRouteData with $EditSemesterRoute {
  final int id;
  const EditSemesterRoute({required this.id});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: child,
      ),

      child: Sheet(child: EditSemesterSheet(semesterId: id)),
    );
  }
}

@TypedGoRoute<CoursesPageRoute>(
  path: "/courses",
  routes: [
    TypedGoRoute<AddCoursesRoute>(path: "create"),
    TypedGoRoute<ViewCourseRoute>(path: "view/:courseId"),
  ],
)
class CoursesPageRoute extends GoRouteData with $CoursesPageRoute {
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: CourseListPage(),
      transitionDuration: Duration(milliseconds: 300),
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
            ).chain(CurveTween(curve: Curves.easeInOutQuad));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}

class AddCoursesRoute extends GoRouteData with $AddCoursesRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
        child: child,
      ),
      child: Sheet(child: const AddCourseSheet()),
    );
  }
}

class ViewCourseRoute extends GoRouteData with $ViewCourseRoute {
  final String courseId;
  const ViewCourseRoute({required this.courseId});
  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: CourseDetailPage(courseId: courseId),
      transitionDuration: Duration(milliseconds: 300),
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
            ).chain(CurveTween(curve: Curves.easeInOutQuad));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }
}
