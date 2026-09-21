import 'package:core/config/flavor.dart';
import 'package:courses/src/data/datasources/course_api_paths.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the Professor route in production', () {
    final paths = CourseApiPaths(
      FlavorConfig(
        flavor: Flavor.production,
        appName: 'Academia',
        apiBaseUrl: 'https://example.test',
      ),
    );

    expect(paths.create, '/professor/api/courses/create/');
  });

  test('uses the QA Professor route outside production', () {
    final paths = CourseApiPaths(
      FlavorConfig(
        flavor: Flavor.staging,
        appName: 'Academia QA',
        apiBaseUrl: 'https://example.test',
      ),
    );

    expect(paths.active, '/qa-professor/api/courses/student/');
  });
}
