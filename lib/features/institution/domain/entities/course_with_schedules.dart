import 'package:academia/features/timetable/timetable.dart';
import 'package:academia/features/course/course.dart';

class CourseWithSchedules {
  final CourseEntity course;
  final List<TimetableEntryEntity> schedules;

  CourseWithSchedules({required this.course, required this.schedules});
}
