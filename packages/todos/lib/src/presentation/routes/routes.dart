import 'package:go_router/go_router.dart';

import 'package:todos/src/presentation/routes/todos_routes.dart';

export 'package:todos/src/presentation/routes/todos_routes.dart'
    show
        TodosRoute,
        CreateTodoListRoute,
        ViewTaskListsRoute,
        ViewTaskListRoute,
        CreateTodoItemRoute,
        PomodoroTimerRoute,
        UpdateTodoItemRoute;

final List<RouteBase> routes = $appRoutes;
