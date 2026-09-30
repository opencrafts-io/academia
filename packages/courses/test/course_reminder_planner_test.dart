import 'package:courses/src/domain/entities/schedule_entry_entity.dart';
import 'package:courses/src/domain/services/course_reminder_planner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('weekly reminders roll to the prior weekday with stable ids', () {
    final entry = ScheduleEntryEntity(
      id: 'entry-1',
      studentCourseId: 'course-1',
      dayOfWeek: 'tuesday',
      startTime: '09:00:00',
      endTime: '10:00:00',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    const planner = CourseReminderPlanner();

    final firstPlan = planner.plan(
      entry,
      reminderMinutes: const [1440, 60, 0],
      now: DateTime(2026, 9, 10, 12),
    );
    final nextPlan = planner.plan(
      entry,
      reminderMinutes: const [1440, 60, 0],
      now: DateTime(2026, 9, 11, 12),
    );

    expect(firstPlan.first.at, DateTime(2026, 9, 14, 9));
    expect(firstPlan.first.weekday, DateTime.monday);
    expect(nextPlan.first.id, firstPlan.first.id);
  });
}
