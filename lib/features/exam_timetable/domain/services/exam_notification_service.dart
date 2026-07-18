import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';

/// Handles scheduling and cancellation of notifications tied to exam
/// timetable lifecycle events.
abstract class ExamNotificationService {
  /// Schedules reminder notifications for the given exam.
  ///
  /// Safe to call repeatedly for the same exam (e.g. after a refresh
  /// picks up a rescheduled date) — each call replaces any previously
  /// scheduled reminders for it rather than duplicating them.
  Future<void> scheduleReminder(ExamTimetable exam);

  /// Cancels the scheduled reminders for the given exam.
  ///
  /// Should be called when the exam is removed from the timetable.
  Future<void> cancelReminder({
    required int institutionId,
    required String courseCode,
  });
}
