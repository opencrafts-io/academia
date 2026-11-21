import 'dart:io';

import 'package:yaml/yaml.dart';

void main(List<String> arguments) {
  // Load the current project's pubspec.yaml
  var pubspecFile = File('pubspec.yaml');
  var pubspecYaml = loadYaml(pubspecFile.readAsStringSync());

  // Load the recommended versions file
  var versionsFile = File('compatible_versions.yaml');
  var versionsYaml = loadYaml(versionsFile.readAsStringSync());

  // Check for version discrepancies
  bool hasIssue = false;
  versionsYaml.forEach((plugin, recommendedVersion) {
    if (pubspecYaml['dependencies'][plugin] != null &&
        pubspecYaml['dependencies'][plugin] != recommendedVersion) {
      print("Incompatible version for $plugin. "
          "Expected $recommendedVersion but found ${pubspecYaml['dependencies'][plugin]}.");
      hasIssue = true;
    }
  });

  if (!hasIssue) {
    print("All plugin versions are compatible.");
  }
}
