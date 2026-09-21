import 'package:core/config/flavor.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CourseApiPaths {
  CourseApiPaths(this._flavorConfig);

  final FlavorConfig _flavorConfig;

  String get _prefix =>
      _flavorConfig.isProduction ? '/professor' : '/qa-professor';

  String get _courses => '$_prefix/api/courses';
  String get create => '$_courses/create/';
  String get active => '$_courses/student/';
  String get archived => '$_courses/student/history/';
  String course(String id) => '$_courses/$id/';
  String archive(String id) => '${course(id)}archive/';
  String lecturers(String courseId) => '${course(courseId)}lecturers/';
  String lecturer(String id) => '$_courses/lecturers/$id/';
}
