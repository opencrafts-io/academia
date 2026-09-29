// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$todosRoute];

RouteBase get $todosRoute => GoRouteData.$route(
  path: '/todos',
  hasOverriddenOnExit: false,
  factory: $TodosRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'create-tasklist',
      hasOverriddenOnExit: false,
      factory: $CreateTodoListRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'tasklist',
      hasOverriddenOnExit: false,
      factory: $ViewTaskListsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: ':taskListId',
          hasOverriddenOnExit: false,
          factory: $ViewTaskListRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'create-todo-item',
      hasOverriddenOnExit: false,
      factory: $CreateTodoItemRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'todo-item/:todoLocalID',
      hasOverriddenOnExit: false,
      factory: $UpdateTodoItemRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'pomodoro-timer',
      hasOverriddenOnExit: false,
      factory: $PomodoroTimerRoute._fromState,
    ),
  ],
);

mixin $TodosRoute on GoRouteData {
  static TodosRoute _fromState(GoRouterState state) => TodosRoute();

  @override
  String get location => GoRouteData.$location('/todos');

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

mixin $CreateTodoListRoute on GoRouteData {
  static CreateTodoListRoute _fromState(GoRouterState state) =>
      CreateTodoListRoute();

  @override
  String get location => GoRouteData.$location('/todos/create-tasklist');

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

mixin $ViewTaskListsRoute on GoRouteData {
  static ViewTaskListsRoute _fromState(GoRouterState state) =>
      ViewTaskListsRoute();

  @override
  String get location => GoRouteData.$location('/todos/tasklist');

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

mixin $ViewTaskListRoute on GoRouteData {
  static ViewTaskListRoute _fromState(GoRouterState state) => ViewTaskListRoute(
    taskListId: int.parse(state.pathParameters['taskListId']!),
  );

  ViewTaskListRoute get _self => this as ViewTaskListRoute;

  @override
  String get location => GoRouteData.$location(
    '/todos/tasklist/${Uri.encodeComponent(_self.taskListId.toString())}',
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

mixin $CreateTodoItemRoute on GoRouteData {
  static CreateTodoItemRoute _fromState(GoRouterState state) =>
      CreateTodoItemRoute(
        taskListLocalID: _$convertMapValue(
          'task-list-local-i-d',
          state.uri.queryParameters,
          int.tryParse,
        ),
      );

  CreateTodoItemRoute get _self => this as CreateTodoItemRoute;

  @override
  String get location => GoRouteData.$location(
    '/todos/create-todo-item',
    queryParams: {
      if (_self.taskListLocalID != null)
        'task-list-local-i-d': _self.taskListLocalID!.toString(),
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

mixin $UpdateTodoItemRoute on GoRouteData {
  static UpdateTodoItemRoute _fromState(GoRouterState state) =>
      UpdateTodoItemRoute(
        todoLocalID: int.parse(state.pathParameters['todoLocalID']!),
      );

  UpdateTodoItemRoute get _self => this as UpdateTodoItemRoute;

  @override
  String get location => GoRouteData.$location(
    '/todos/todo-item/${Uri.encodeComponent(_self.todoLocalID.toString())}',
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
