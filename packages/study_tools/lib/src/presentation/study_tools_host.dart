import '../domain/entities/study_entities.dart';

import 'package:flutter/widgets.dart';

/// App-level adapter that supplies Professor course UUIDs without coupling
/// this package to the courses feature.
class StudyToolsHost {
  static Future<List<StudyCourseOption>> Function()? loadCourses;
  static void Function(BuildContext context)? openPaywall;
}
