part of '../routes.dart';

@TypedGoRoute<ExamTimetableRoute>(
  path: "/exam-timetable/:institutionId",
  routes: [TypedGoRoute<ExamTimetableSearchRoute>(path: "search")],
)
class ExamTimetableRoute extends GoRouteData with $ExamTimetableRoute {
  final int institutionId;

  const ExamTimetableRoute({required this.institutionId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExamTimetableHomeScreen(institutionId: institutionId);
  }
}

class ExamTimetableSearchRoute extends GoRouteData
    with $ExamTimetableSearchRoute {
  final int institutionId;

  const ExamTimetableSearchRoute({required this.institutionId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ExamTimetableSearchScreen(institutionId: institutionId);
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
      child: Sheet(child: InstitutionKeysView(institutionID: institutionID)),
    );
  }
}

class EditStudentProfileRoute extends GoRouteData
    with $EditStudentProfileRoute {
  final int profileId;
  final int institutionID;
  const EditStudentProfileRoute({
    required this.profileId,
    required this.institutionID,
  });
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
      transitionCurve: Curves.easeInOutCubic,
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(
          top: MediaQuery.viewPaddingOf(context).top,
          bottom: MediaQuery.viewPaddingOf(context).bottom,
        ),

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
  path: "/local-courses",
  routes: [
    TypedGoRoute<AddCoursesRoute>(path: "create"),
    TypedGoRoute<ViewCourseRoute>(path: "view/:courseId"),
  ],
)
class CoursesPageRoute extends GoRouteData with $CoursesPageRoute {
  @override
  String? redirect(BuildContext context, GoRouterState state) {
    if (state.uri.path == '/local-courses') {
      return const courses_package.CourseListRoute().location;
    }
    return null;
  }
}

class AddCoursesRoute extends GoRouteData with $AddCoursesRoute {
  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      const courses_package.CreateCourseRoute().location;
}

class ViewCourseRoute extends GoRouteData with $ViewCourseRoute {
  final String courseId;
  const ViewCourseRoute({required this.courseId});
  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      courses_package.CourseDetailRoute(courseId: courseId).location;
}
