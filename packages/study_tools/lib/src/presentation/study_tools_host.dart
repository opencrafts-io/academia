import '../domain/entities/study_entities.dart';

import 'package:flutter/widgets.dart';

/// App-level adapter that supplies Professor course UUIDs without coupling
/// this package to the courses feature.
class StudyToolsHost {
  /// Current signed-in account used to scope Study Tools local data.
  ///
  /// The app updates this when its profile state changes. Keeping this value
  /// outside ProfileBloc lets package services read the active account without
  /// asking GetIt for a new factory-created bloc.
  static String? currentAccountId;

  static Future<List<StudyCourseOption>> Function()? loadCourses;
  static Future<void> Function(BuildContext context)? openPaywall;
  static void Function(StudyPodcast podcast)? openPodcastPlayer;
}
