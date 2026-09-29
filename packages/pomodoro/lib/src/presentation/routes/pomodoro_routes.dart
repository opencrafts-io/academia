import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/src/presentation/views/pomodoro_todo_picker_screen.dart';
import 'package:pomodoro/src/presentation/views/pomodoro_timer_screen.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

part 'pomodoro_routes.g.dart';

@TypedGoRoute<PomodoroTimerRoute>(path: '/todos/pomodoro-timer')
class PomodoroTimerRoute extends GoRouteData with $PomodoroTimerRoute {
  const PomodoroTimerRoute({this.todoLocalID});

  final int? todoLocalID;

  @override
  CustomTransitionPage<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: PomodoroTimerScreen(todoLocalId: todoLocalID),
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final position = animation.drive(
          Tween<Offset>(
            begin: const Offset(0.04, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        );
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: position, child: child),
        );
      },
    );
  }
}

@TypedGoRoute<PomodoroTodoPickerRoute>(path: '/todos/pomodoro-todo-picker')
class PomodoroTodoPickerRoute extends GoRouteData
    with $PomodoroTodoPickerRoute {
  const PomodoroTodoPickerRoute({this.selectedTodoLocalID});

  final int? selectedTodoLocalID;

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
            size: SheetSize.stretch,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          physics: BouncingSheetPhysics(),
          child: PomodoroTodoPickerScreen(
            selectedTodoLocalId: selectedTodoLocalID,
          ),
        ),
      ),
    );
  }
}
