import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:todos/src/presentation/views/create_todo_item_screen.dart';
import 'package:todos/src/presentation/views/create_todo_list_screen.dart';
import 'package:todos/src/presentation/views/todo_home_screen.dart';
import 'package:todos/src/presentation/views/update_todo_item_screen.dart';
import 'package:todos/src/presentation/views/view_todo_list_screen.dart';

part 'todos_routes.g.dart';

@TypedGoRoute<TodosRoute>(
  path: "/todos",
  routes: [
    TypedGoRoute<CreateTodoListRoute>(path: "create-tasklist"),
    TypedGoRoute<ViewTaskListsRoute>(
      path: "tasklist",
      routes: [TypedGoRoute<ViewTaskListRoute>(path: ":taskListId")],
    ),

    TypedGoRoute<CreateTodoItemRoute>(path: "create-todo-item"),
    TypedGoRoute<UpdateTodoItemRoute>(path: "todo-item/:todoLocalID"),
  ],
)
class TodosRoute extends GoRouteData with $TodosRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodoHomeScreen();
  }
}

class CreateTodoListRoute extends GoRouteData with $CreateTodoListRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: true,
      swipeDismissible: true,
      transitionCurve: Curves.bounceIn,
      viewportBuilder: (context, child) =>
          SheetViewport(padding: EdgeInsets.zero, child: child),
      child: SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.stretch,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),
          child: CreateTodoListScreen(),
        ),
      ),
    );
  }
}

class ViewTaskListRoute extends GoRouteData with $ViewTaskListRoute {
  final int taskListId;
  ViewTaskListRoute({required this.taskListId});
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: true,
      swipeDismissible: true,
      viewportBuilder: (context, child) =>
          SheetViewport(padding: EdgeInsets.zero, child: child),
      child: SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),

          child: ViewTodoListScreen(todoListId: taskListId),
        ),
      ),
    );
  }
}

class ViewTaskListsRoute extends GoRouteData with $ViewTaskListsRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: true,
      swipeDismissible: true,
      viewportBuilder: (context, child) => SheetViewport(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
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
          decoration: MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),

          child: CreateTodoListScreen(),
        ),
      ),
    );
  }
}

class CreateTodoItemRoute extends GoRouteData with $CreateTodoItemRoute {
  final int? taskListLocalID;
  CreateTodoItemRoute({this.taskListLocalID});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: false,
      swipeDismissible: true,
      transitionCurve: Curves.easeIn,
      viewportBuilder: (context, child) =>
          SheetViewport(padding: EdgeInsets.zero, child: child),
      child: SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),
          child: CreateTodoItemScreen(taskListLocalID: taskListLocalID),
        ),
      ),
    );
  }
}

class UpdateTodoItemRoute extends GoRouteData with $UpdateTodoItemRoute {
  final int todoLocalID;

  const UpdateTodoItemRoute({required this.todoLocalID});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalSheetPage(
      fullscreenDialog: false,
      swipeDismissible: true,
      transitionCurve: Curves.easeIn,
      viewportBuilder: (context, child) =>
          SheetViewport(padding: EdgeInsets.zero, child: child),
      child: SheetKeyboardDismissible(
        dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.fit,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),
          child: UpdateTodoItemScreen(todoLocalId: todoLocalID),
        ),
      ),
    );
  }
}
