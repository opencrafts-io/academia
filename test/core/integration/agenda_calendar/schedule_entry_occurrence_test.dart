import 'package:academia/core/integration/agenda_calendar/schedule_entry_occurrence.dart';
import 'package:courses/courses.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recurring class markers stop after the course end date', () {
    final entry = _entry(termEndDate: DateTime(2026, 10, 5));

    expect(scheduleEntryOccursOnDay(entry, DateTime(2026, 9, 28)), isTrue);
    expect(scheduleEntryOccursOnDay(entry, DateTime(2026, 10, 5)), isTrue);
    expect(scheduleEntryOccursOnDay(entry, DateTime(2026, 10, 12)), isFalse);
  });

  test('specific date class markers also respect the course end date', () {
    final entry = _entry(termEndDate: DateTime(2026, 10, 5))
        .copyWith(specificDate: DateTime(2026, 10, 12));

    expect(scheduleEntryOccursOnDay(entry, DateTime(2026, 10, 12)), isFalse);
  });
}

ScheduleEntryEntity _entry({required DateTime termEndDate}) =>
    ScheduleEntryEntity(
      id: 'schedule-1',
      studentCourseId: 'course-1',
      dayOfWeek: 'monday',
      startTime: '09:00',
      endTime: '10:00',
      courseTermEndDate: termEndDate,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 1),
    );
