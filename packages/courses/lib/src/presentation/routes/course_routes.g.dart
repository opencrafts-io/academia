// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$courseListRoute];

RouteBase get $courseListRoute => GoRouteData.$route(
  path: '/courses',
  hasOverriddenOnExit: false,
  factory: $CourseListRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'create',
      hasOverriddenOnExit: false,
      factory: $CreateCourseRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'history',
      hasOverriddenOnExit: false,
      factory: $CourseHistoryRoute._fromState,
    ),
    GoRouteData.$route(
      path: ':courseId',
      hasOverriddenOnExit: false,
      factory: $CourseDetailRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'edit',
          hasOverriddenOnExit: false,
          factory: $EditCourseRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'lecturers/create',
          hasOverriddenOnExit: false,
          factory: $CreateLecturerRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'lecturers/:lecturerId/edit',
          hasOverriddenOnExit: false,
          factory: $EditLecturerRoute._fromState,
        ),
      ],
    ),
  ],
);

mixin $CourseListRoute on GoRouteData {
  static CourseListRoute _fromState(GoRouterState state) =>
      const CourseListRoute();

  @override
  String get location => GoRouteData.$location('/courses');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateCourseRoute on GoRouteData {
  static CreateCourseRoute _fromState(GoRouterState state) =>
      const CreateCourseRoute();

  @override
  String get location => GoRouteData.$location('/courses/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseHistoryRoute on GoRouteData {
  static CourseHistoryRoute _fromState(GoRouterState state) =>
      const CourseHistoryRoute();

  @override
  String get location => GoRouteData.$location('/courses/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseDetailRoute on GoRouteData {
  static CourseDetailRoute _fromState(GoRouterState state) =>
      CourseDetailRoute(courseId: state.pathParameters['courseId']!);

  CourseDetailRoute get _self => this as CourseDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/courses/${Uri.encodeComponent(_self.courseId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditCourseRoute on GoRouteData {
  static EditCourseRoute _fromState(GoRouterState state) =>
      EditCourseRoute(courseId: state.pathParameters['courseId']!);

  EditCourseRoute get _self => this as EditCourseRoute;

  @override
  String get location => GoRouteData.$location(
    '/courses/${Uri.encodeComponent(_self.courseId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CreateLecturerRoute on GoRouteData {
  static CreateLecturerRoute _fromState(GoRouterState state) =>
      CreateLecturerRoute(courseId: state.pathParameters['courseId']!);

  CreateLecturerRoute get _self => this as CreateLecturerRoute;

  @override
  String get location => GoRouteData.$location(
    '/courses/${Uri.encodeComponent(_self.courseId)}/lecturers/create',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditLecturerRoute on GoRouteData {
  static EditLecturerRoute _fromState(GoRouterState state) => EditLecturerRoute(
    courseId: state.pathParameters['courseId']!,
    lecturerId: state.pathParameters['lecturerId']!,
  );

  EditLecturerRoute get _self => this as EditLecturerRoute;

  @override
  String get location => GoRouteData.$location(
    '/courses/${Uri.encodeComponent(_self.courseId)}/lecturers/${Uri.encodeComponent(_self.lecturerId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
