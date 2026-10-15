import 'package:courses/courses.dart' as courses;

class MagnetCourseImport {
  final courses.CreateCourseParams course;
  final List<courses.ScheduleEntryEntity> schedules;

  const MagnetCourseImport({required this.course, required this.schedules});
}
