import 'package:core/config/flavor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_tools/src/data/datasources/study_tools_api_paths.dart';

void main() {
  test('uses production notes paths and keeps trailing slashes', () {
    final paths = StudyToolsApiPaths(_flavor(Flavor.production));
    expect(paths.collection, '/professor/api/notes/');
    expect(paths.detail(12), '/professor/api/notes/12/');
    expect(paths.generate(12), '/professor/api/notes/12/generate/');
    expect(paths.job(4), '/professor/api/notes/jobs/4/');
    expect(paths.questions(12), '/professor/api/notes/12/questions/');
    expect(paths.podcast(12), '/professor/api/notes/12/podcast/');
  });

  test('uses QA notes paths for staging and development', () {
    for (final flavor in [Flavor.staging, Flavor.development]) {
      final paths = StudyToolsApiPaths(_flavor(flavor));
      expect(paths.collection, '/qa-professor/api/notes/');
      expect(paths.detail(12), '/qa-professor/api/notes/12/');
      expect(paths.podcast(12), '/qa-professor/api/notes/12/podcast/');
    }
  });
}

FlavorConfig _flavor(Flavor flavor) => FlavorConfig(
  flavor: flavor,
  appName: 'Academia',
  apiBaseUrl: 'https://example.test',
);
