import 'package:academia/features/todos/todos.dart';

/// Handles scheduling and cancellation of notifications tied to todo lifecycle events.
abstract class TodoNotificationService {
  /// Schedules a reminder notification for the given todo.
  ///
  /// Should be called when a todo is created with a due date.
  Future<void> scheduleReminder(TodoItemEntity todo);

  /// Reschedules an existing reminder when a todo's due date changes.
  ///
  /// Cancels the previous notification and schedules a new one.
  Future<void> rescheduleReminder(TodoItemEntity todo);

  /// Cancels the scheduled notification for the given todo.
  ///
  /// Should be called on deletion or when a todo is marked complete.
  Future<void> cancelReminder(int todoId);

  /// Cancels all scheduled todo notifications.
  ///
  /// Should be called when all todos are deleted or cleared.
  Future<void> cancelAllReminders();

  /// Shows a playful notification acknowledging the todo was deleted.
  ///
  /// Uses [todo.title] to personalise the message.
  /// nudges — lighthearted, not alarming.
  Future<void> notifyDeleted(TodoItemEntity todo);
}
