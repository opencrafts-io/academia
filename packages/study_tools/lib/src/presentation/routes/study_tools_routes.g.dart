// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tools_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$studyToolsRoute, $studyPracticeRoute];

RouteBase get $studyToolsRoute => GoRouteData.$route(
  path: '/study-tools',
  hasOverriddenOnExit: false,
  factory: $StudyToolsRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'material/:materialId',
      hasOverriddenOnExit: false,
      factory: $StudyMaterialRoute._fromState,
    ),
  ],
);

mixin $StudyToolsRoute on GoRouteData {
  static StudyToolsRoute _fromState(GoRouterState state) => StudyToolsRoute(
    courseId: state.uri.queryParameters['course-id'],
    courseLabel: state.uri.queryParameters['course-label'],
  );

  StudyToolsRoute get _self => this as StudyToolsRoute;

  @override
  String get location => GoRouteData.$location(
    '/study-tools',
    queryParams: {
      if (_self.courseId != null) 'course-id': _self.courseId,
      if (_self.courseLabel != null) 'course-label': _self.courseLabel,
    },
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

mixin $StudyMaterialRoute on GoRouteData {
  static StudyMaterialRoute _fromState(GoRouterState state) =>
      StudyMaterialRoute(
        materialId: int.parse(state.pathParameters['materialId']!),
      );

  StudyMaterialRoute get _self => this as StudyMaterialRoute;

  @override
  String get location => GoRouteData.$location(
    '/study-tools/material/${Uri.encodeComponent(_self.materialId.toString())}',
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

RouteBase get $studyPracticeRoute => GoRouteData.$route(
  path: '/study-tools/practice/:materialId/:setId/:format',
  hasOverriddenOnExit: false,
  factory: $StudyPracticeRoute._fromState,
);

mixin $StudyPracticeRoute on GoRouteData {
  static StudyPracticeRoute _fromState(GoRouterState state) =>
      StudyPracticeRoute(
        materialId: int.parse(state.pathParameters['materialId']!),
        setId: int.parse(state.pathParameters['setId']!),
        format: state.pathParameters['format']!,
      );

  StudyPracticeRoute get _self => this as StudyPracticeRoute;

  @override
  String get location => GoRouteData.$location(
    '/study-tools/practice/${Uri.encodeComponent(_self.materialId.toString())}/${Uri.encodeComponent(_self.setId.toString())}/${Uri.encodeComponent(_self.format)}',
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
