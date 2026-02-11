import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:workmanager/workmanager.dart';
import 'package:academia/background_task/background_task.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CourseAlertBackgroundTask extends BackgroundTask {
  final CourseRepository courseRepository;
  final TimetableEntryRepository timetableEntryRepository;

  CourseAlertBackgroundTask({
    required this.courseRepository,
    required this.timetableEntryRepository,
  });

  @override
  String? get taskTag => 'io.opencrafts.academia.course.alert';

  @override
  String get taskName => 'io.opencrafts.academia.course.alert';

  @override
  Duration? get frequency => const Duration(minutes: 5);

  @override
  ExistingWorkPolicy get existingWorkPolicy => ExistingWorkPolicy.keep;

  @override
  Future<bool> execute(Map<String, dynamic>? inputData) async {
    try {
      final now = DateTime.now();

      // Get today's timetable entries
      final entriesResult = await timetableEntryRepository
          .watchTodayTimetableEntries()
          .first;

      await entriesResult.fold(
        (failure) async {
          debugPrint("Failed to fetch today's entries: ${failure.message}");
          return false;
        },
        (entries) async {
          for (final entry in entries) {
            final classStartTime = entry.startDate;
            final timeDifference = classStartTime.difference(now);

            // Get course details
            final courseResult = await courseRepository.getCourse(
              entry.courseId,
            );

            await courseResult.fold(
              (failure) async {
                debugPrint("Failed to fetch course: ${failure.message}");
              },
              (course) async {
                // Build location string
                final location = _buildLocationString(
                  building: entry.building,
                  room: entry.room,
                  location: entry.location,
                );

                // Stage 1: 30 minutes before class
                if (timeDifference.inMinutes <= 30 &&
                    timeDifference.inMinutes > 25) {
                  await _send30MinuteAlert(
                    course: course,
                    entry: entry,
                    location: location,
                  );
                }

                // Stage 2: 15 minutes before class
                if (timeDifference.inMinutes <= 15 &&
                    timeDifference.inMinutes > 10) {
                  await _send15MinuteAlert(
                    course: course,
                    entry: entry,
                    location: location,
                  );
                }

                // Stage 3: Class starting now
                if (timeDifference.inMinutes <= 0 &&
                    timeDifference.inMinutes > -5) {
                  await _sendClassStartingAlert(
                    course: course,
                    entry: entry,
                    location: location,
                  );
                }

                // Stage 4: Class in progress - show progress notification
                if (timeDifference.inMinutes < 0) {
                  final classEndTime = classStartTime.add(
                    Duration(minutes: entry.durationMinutes),
                  );
                  final isClassOngoing = now.isBefore(classEndTime);

                  if (isClassOngoing) {
                    await _sendClassInProgressAlert(
                      course: course,
                      entry: entry,
                      location: location,
                      startTime: classStartTime,
                      endTime: classEndTime,
                    );
                  }
                }
              },
            );
          }
          return true;
        },
      );

      return true;
    } catch (e) {
      debugPrint("Course Alert Background Task Error: $e");
      return false;
    }
  }

  /// Stage 1: Alert 30 minutes before class
  Future<void> _send30MinuteAlert({
    required course,
    required entry,
    required String location,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id!, 30),
        channelKey: 'course_alerts',
        title: '⏰ Class in 30 Minutes',
        body:
            '${course.courseName} (${course.courseCode})\n'
            '📍 $location\n'
            '👨‍🏫 ${course.instructor}',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Reminder,
        backgroundColor: Color(course.color ?? 0xFF007DFD),
        color: Colors.white,
        payload: {
          "type": "30_minute_alert",
          "entry_id": entry.id!,
          "course_id": course.id ?? '',
        },
        wakeUpScreen: true,
        criticalAlert: true,
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/alarm.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW_DETAILS',
          label: 'View Details',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Stage 2: Alert 15 minutes before class
  Future<void> _send15MinuteAlert({
    required course,
    required entry,
    required String location,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id!, 15),
        channelKey: 'course_alerts',
        title: '🚨 Class in 15 Minutes!',
        body:
            '${course.courseName} is starting soon\n'
            '📍 $location\n'
            '⏰ Time to head there!',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Alarm,
        backgroundColor: Color(course.color ?? 0xFFFF6B6B),
        color: Colors.white,
        payload: {
          "type": "15_minute_alert",
          "entry_id": entry.id!,
          "course_id": course.id ?? '',
        },
        wakeUpScreen: true,
        criticalAlert: true,
        fullScreenIntent: true,
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/alarm.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'NAVIGATE',
          label: 'Navigate',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'VIEW_DETAILS',
          label: 'Details',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Stage 3: Alert when class is starting
  Future<void> _sendClassStartingAlert({
    required course,
    required entry,
    required String location,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id!, 0),
        channelKey: 'course_alerts',
        title: '🔔 Class Starting Now!',
        body:
            '${course.courseName} has begun\n'
            '📍 $location\n'
            '⏱️ Duration: ${entry.durationMinutes} minutes',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Alarm,
        backgroundColor: Color(course.color ?? 0xFFFF0000),
        color: Colors.white,
        payload: {
          "type": "class_starting",
          "entry_id": entry.id!,
          "course_id": course.id ?? '',
        },
        wakeUpScreen: true,
        criticalAlert: true,
        fullScreenIntent: true,
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/alarm.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'JOIN_CLASS',
          label: 'Join',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Stage 4: Show progress notification during class
  Future<void> _sendClassInProgressAlert({
    required course,
    required entry,
    required String location,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final now = DateTime.now();
    final totalDuration = endTime.difference(startTime).inMinutes;
    final elapsed = now.difference(startTime).inMinutes;
    final remaining = endTime.difference(now).inMinutes;

    // Calculate progress (0.0 to 1.0)
    final progress = elapsed / totalDuration;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id!, -1),
        channelKey: 'course_alerts',
        title: '📚 ${course.courseName} in Progress',
        body:
            '⏱️ $remaining minutes remaining\n'
            '📍 $location\n'
            '👨‍🏫 ${course.instructor}',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.ProgressBar,
        category: NotificationCategory.Progress,
        backgroundColor: Color(course.color ?? 0xFF4CAF50),
        color: Colors.white,
        progress: (progress * 100).toDouble(),
        payload: {
          "type": "class_in_progress",
          "entry_id": entry.id!,
          "course_id": course.id ?? '',
          "remaining_minutes": remaining.toString(),
        },
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/alarm.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'END_CLASS',
          label: 'End Early',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'VIEW_NOTES',
          label: 'Notes',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  /// Build location string from entry components
  String _buildLocationString({
    String? building,
    String? room,
    String? location,
  }) {
    final parts = <String>[];

    if (building != null && building.isNotEmpty) {
      parts.add(building);
    }

    if (room != null && room.isNotEmpty) {
      parts.add(room);
    }

    if (location != null && location.isNotEmpty) {
      parts.add(location);
    }

    return parts.isEmpty ? 'Location TBA' : parts.join(', ');
  }

  /// Generate unique notification ID based on entry ID and alert stage
  /// This ensures we can have multiple notifications for the same class
  int _generateNotificationId(String entryId, int stage) {
    // Use hashCode of entryId combined with stage
    // Stage: 30 (30min), 15 (15min), 0 (starting), -1 (in progress)
    return (entryId.hashCode + stage * 1000).abs() % 2147483647;
  }
}
