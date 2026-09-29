// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$pomodoroTimerRoute];

RouteBase get $pomodoroTimerRoute => GoRouteData.$route(
  path: '/todos/pomodoro-timer',
  hasOverriddenOnExit: false,
  factory: $PomodoroTimerRoute._fromState,
);

mixin $PomodoroTimerRoute on GoRouteData {
  static PomodoroTimerRoute _fromState(GoRouterState state) =>
      PomodoroTimerRoute(
        todoLocalID: _$convertMapValue(
          'todo-local-i-d',
          state.uri.queryParameters,
          int.tryParse,
        ),
      );

  PomodoroTimerRoute get _self => this as PomodoroTimerRoute;

  @override
  String get location => GoRouteData.$location(
    '/todos/pomodoro-timer',
    queryParams: {
      if (_self.todoLocalID != null)
        'todo-local-i-d': _self.todoLocalID!.toString(),
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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
