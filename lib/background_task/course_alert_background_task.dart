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

      return await entriesResult.fold(
        (failure) async {
          debugPrint("Failed to fetch today's entries: ${failure.message}");
          return false;
        },
        (entries) async {
          for (final entry in entries) {
            final classStartTime = _buildTodayDateTime(entry.startDate, now);
            final timeDifference = classStartTime.difference(now);

            // Get course details
            final courseResult = await courseRepository.getCourse(
              entry.courseId,
            );

            await courseResult.fold(
              (failure) async {
                debugPrint("Failed to fetch course: ${failure.message}");
                return false;
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

    } catch (e) {
      debugPrint("Course Alert Background Task Error: $e");
      return false;
    }
  }

  /// Build a DateTime for today using the time from startDate
  /// Since startDate only contains time info (the date portion is irrelevant),
  /// we extract the time and combine it with today's date
  DateTime _buildTodayDateTime(DateTime timeSource, DateTime today) {
    return DateTime(
      today.year,
      today.month,
      today.day,
      timeSource.hour,
      timeSource.minute,
      timeSource.second,
    );
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
        title: 'Upcoming ${course.courseName}',
        summary: 'Starting in 30 minutes',
        body: '• Room: $location\n• Prep: Check your materials',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Reminder,
        backgroundColor: course.color,
        color: Colors.white,
        payload: {},
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
        title: 'Upcoming: ${course.courseName}',
        summary: 'Starting in 15 minutes',
        body: '• Room: $location\n• Prep: Check your materials',
        actionType: ActionType.KeepOnTop,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Alarm,
        backgroundColor: course.color,
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
        largeIcon: 'asset://assets/icons/time.png',
        roundedLargeIcon: true,
      ),
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
        title: 'Time for ${course.courseName}!',
        summary: 'Starting Now • ${entry.durationMinutes}m',
        body: '📍 $location\n👨‍🏫 ${course.instructor}',
        actionType: ActionType.KeepOnTop,
        wakeUpScreen: true,
        criticalAlert: true,
        locked: true,
        autoDismissible: false,
        notificationLayout: NotificationLayout.BigText,
        displayOnBackground: true,
        displayOnForeground: true,
        category: NotificationCategory.Alarm,
        backgroundColor: course.color,
        color: Colors.white,
        payload: {},
        fullScreenIntent: true,
        largeIcon: 'asset://assets/icons/motarboard.png',
        roundedLargeIcon: true,
      ),
      actionButtons: [],
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
        title: ' ${course.courseName} is in progress.',
        summary: '${remaining.toString()} minutes left.',
        body:'$location • ${course.instructor}',
        actionType: ActionType.KeepOnTop,
        notificationLayout: NotificationLayout.ProgressBar,
        category: NotificationCategory.Progress,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: course.color,
        color: Colors.black,
        showWhen: true,
        chronometer: Duration(minutes: elapsed),
        timeoutAfter: Duration(minutes: remaining),
        progress: (progress * 100).toDouble(),
        payload: {},
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/timer.png',
        roundedLargeIcon: true,
      ),
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
