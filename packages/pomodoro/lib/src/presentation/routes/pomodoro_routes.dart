import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/src/presentation/views/pomodoro_timer_screen.dart';

part 'pomodoro_routes.g.dart';

@TypedGoRoute<PomodoroTimerRoute>(path: '/todos/pomodoro-timer')
class PomodoroTimerRoute extends GoRouteData with $PomodoroTimerRoute {
  const PomodoroTimerRoute({this.todoLocalID});

  final int? todoLocalID;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PomodoroTimerScreen(todoLocalId: todoLocalID);
  }
}
