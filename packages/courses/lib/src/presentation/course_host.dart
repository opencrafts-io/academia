import 'package:flutter/widgets.dart';

import '../domain/entities/course_entity.dart';

/// App-level navigation adapter keeps course detail independent from tools.
class CourseHost {
  static Future<void> Function(BuildContext context, CourseEntity course)?
  openMaterials;
}
