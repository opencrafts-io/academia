import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/injection_container.dart';
import 'package:notifications/notifications.dart';
import 'package:todos/todos.dart' as todos;

class AcademiaNotificationActionHandler implements NotificationActionHandler {
  const AcademiaNotificationActionHandler();

  @override
  Future<void> handle(NotificationAction action) async {
    final todoLocalId = int.tryParse(action.payload['localId'] ?? '');
    if (todoLocalId != null) {
      await _handleTodoAction(action.buttonKey, todoLocalId);
      return;
    }

    final examInstitutionId = int.tryParse(
      action.payload['institutionId'] ?? '',
    );
    final courseCode = action.payload['courseCode'];
    if (examInstitutionId != null && courseCode?.trim().isNotEmpty == true) {
      AppRouter.router.push(
        ExamTimetableRoute(institutionId: examInstitutionId).location,
      );
      return;
    }

    if (action.buttonKey == 'OPEN_APP') {
      AppRouter.router.go(HomeRoute().location);
    }
  }

  Future<void> _handleTodoAction(String? buttonKey, int todoLocalId) async {
    switch (buttonKey) {
      case 'btn-do':
        AppRouter.router.push(
          todos.UpdateTodoItemRoute(todoLocalID: todoLocalId).location,
        );
      case 'btn-done':
        await sl<todos.CompleteTodoItem>()(todoLocalId);
        if (sl.isRegistered<todos.TodoNotificationService>()) {
          await sl<todos.TodoNotificationService>().cancelReminder(todoLocalId);
        }
        if (sl.isRegistered<todos.TodoItemCubit>()) {
          unawaited(sl<todos.TodoItemCubit>().loadItems());
        }
    }
  }
}
