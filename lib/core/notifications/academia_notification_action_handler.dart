import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:notifications/notifications.dart';

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
          UpdateTodoItemRoute(todoLocalID: todoLocalId).location,
        );
      case 'btn-done':
        await sl<CompleteTodoItem>()(todoLocalId);
        if (sl.isRegistered<TodoNotificationService>()) {
          await sl<TodoNotificationService>().cancelReminder(todoLocalId);
        }
        if (sl.isRegistered<TodoItemCubit>()) {
          unawaited(sl<TodoItemCubit>().loadItems());
        }
    }
  }
}
