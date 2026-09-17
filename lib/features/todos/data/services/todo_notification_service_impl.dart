import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:notifications/notifications.dart';

const int _kSlotsPerEntry = 10;

enum _ReminderSlot { dayBefore, hourBefore, thirtyMinBefore, due }

class TodoNotificationServiceImpl implements TodoNotificationService {
  TodoNotificationServiceImpl(this._scheduler);

  final LocalNotificationScheduler _scheduler;

  int _idFor(int localId, _ReminderSlot slot) =>
      NotificationNamespaces.todos + (localId * _kSlotsPerEntry) + slot.index;

  @override
  Future<void> scheduleReminder(TodoItemEntity todo) async {
    if (todo.due == null) return;

    for (final slot in _slotsFor(todo.priority)) {
      final scheduledAt = todo.due!.subtract(_offsetFor(slot));

      if (scheduledAt.isBefore(DateTime.now())) continue;

      await _scheduler.schedule(
        LocalNotificationRequest(
          id: _idFor(todo.localId, slot),
          channel: LocalNotificationChannel.reminders,
          title: _reminderTitle(slot),
          summary: 'Priority: ${todo.priority.name}',
          body: todo.title,
          category: LocalNotificationCategory.reminder,
          payload: {'localId': todo.localId.toString()},
          schedule: LocalNotificationSchedule.at(scheduledAt, precise: true),
          actions: const [
            LocalNotificationAction(
              id: 'btn-do',
              label: 'View To-do',
              colorValue: 0xFF2196F3,
            ),
            LocalNotificationAction(
              id: 'btn-done',
              label: 'Mark Done',
              colorValue: 0xFF4CAF50,
            ),
          ],
          presentation: const LocalNotificationPresentation(
            largeIcon: 'asset://assets/icons/clock.png',
            wakeUpScreen: true,
            criticalAlert: true,
            layout: LocalNotificationLayout.bigText,
          ),
        ),
      );
    }
  }

  @override
  Future<void> rescheduleReminder(TodoItemEntity todo) async {
    await cancelReminder(todo.localId);
    await scheduleReminder(todo);
  }

  @override
  Future<void> cancelReminder(int localId) async {
    for (final slot in _ReminderSlot.values) {
      await _scheduler.cancel(_idFor(localId, slot));
    }
  }

  @override
  Future<void> cancelAllReminders() async {
    await _scheduler.cancelAllSchedules();
  }

  @override
  Future<void> notifyDeleted(TodoItemEntity todo) async {
    await _scheduler.schedule(
      LocalNotificationRequest(
        id: _idFor(todo.localId, _ReminderSlot.dayBefore),
        channel: LocalNotificationChannel.reminders,
        title: _deletedTitle(todo),
        body: _deletedBody(todo),
        presentation: const LocalNotificationPresentation(
          largeIcon: 'asset://assets/icons/trumpet.png',
        ),
      ),
    );
  }

  List<_ReminderSlot> _slotsFor(TodoPriority priority) {
    return switch (priority) {
      TodoPriority.high => _ReminderSlot.values,
      TodoPriority.medium => [
        _ReminderSlot.dayBefore,
        _ReminderSlot.hourBefore,
        _ReminderSlot.due,
      ],
      TodoPriority.low => [_ReminderSlot.dayBefore, _ReminderSlot.due],
      _ => [_ReminderSlot.dayBefore, _ReminderSlot.due],
    };
  }

  Duration _offsetFor(_ReminderSlot slot) {
    return switch (slot) {
      _ReminderSlot.dayBefore => const Duration(hours: 24),
      _ReminderSlot.hourBefore => const Duration(hours: 1),
      _ReminderSlot.thirtyMinBefore => const Duration(minutes: 30),
      _ReminderSlot.due => Duration.zero,
    };
  }

  String _reminderTitle(_ReminderSlot slot) {
    return switch (slot) {
      _ReminderSlot.dayBefore => '📅 Due tomorrow',
      _ReminderSlot.hourBefore => '⏰ Due in an hour',
      _ReminderSlot.thirtyMinBefore => '🔥 Due in 30 minutes',
      _ReminderSlot.due => '🚨 This is due right now',
    };
  }

  String _deletedTitle(TodoItemEntity todo) {
    return switch (todo.priority) {
      TodoPriority.high => 'A high priority item? Gone? 👀',
      TodoPriority.medium => 'Well that\'s one way to handle it 🙃',
      TodoPriority.low => 'Good riddance, honestly 🗑️',
      _ => 'And just like that... 💨',
    };
  }

  String _deletedBody(TodoItemEntity todo) {
    return switch (todo.priority) {
      TodoPriority.high =>
        '\'${todo.title}\' was deleted. Bold move. We\'re watching.',
      TodoPriority.medium => '\'${todo.title}\' has left the chat. Forever.',
      TodoPriority.low =>
        '\'${todo.title}\' is gone. We both knew it was never happening.',
      _ => '\'${todo.title}\' has been yeeted into the void.',
    };
  }
}
