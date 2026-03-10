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
  Duration? get frequency => const Duration(hours: 12);

  @override
  ExistingWorkPolicy get existingWorkPolicy => ExistingWorkPolicy.replace;

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

                // Stage 1: Schedule 30 minutes before class
                final alert30 = classStartTime.subtract(
                  const Duration(minutes: 30),
                );
                if (alert30.isAfter(now)) {
                  await _send30MinuteAlert(
                    course: course,
                    entry: entry,
                    location: location,
                    scheduledDate: alert30,
                  );
                }

                // Stage 2: Schedule 15 minutes before class
                final alert15 = classStartTime.subtract(
                  const Duration(minutes: 15),
                );
                if (alert15.isAfter(now)) {
                  await _send15MinuteAlert(
                    course: course,
                    entry: entry,
                    location: location,
                    scheduledDate: alert15,
                  );
                }

                // Stage 3: Schedule alert for class start
                if (classStartTime.isAfter(now)) {
                  await _sendClassStartingAlert(
                    course: course,
                    entry: entry,
                    location: location,
                    scheduledDate: classStartTime,
                  );
                } else if (now.isBefore(
                  classStartTime.add(const Duration(minutes: 5)),
                )) {
                  // If class just started (within 5 mins), send immediately
                  await _sendClassStartingAlert(
                    course: course,
                    entry: entry,
                    location: location,
                  );
                }

                // Stage 4: Class in progress - show status notification
                final classEndTime = classStartTime.add(
                  Duration(minutes: entry.durationMinutes),
                );

                if (classStartTime.isAfter(now)) {
                  // Schedule the status notification to appear when class starts
                  await _sendClassInProgressAlert(
                    course: course,
                    entry: entry,
                    location: location,
                    startTime: classStartTime,
                    endTime: classEndTime,
                    scheduledDate: classStartTime,
                  );
                } else if (now.isBefore(classEndTime)) {
                  // Class is already ongoing, show it immediately
                  await _sendClassInProgressAlert(
                    course: course,
                    entry: entry,
                    location: location,
                    startTime: classStartTime,
                    endTime: classEndTime,
                  );
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
  DateTime _buildTodayDateTime(DateTime timeSource, DateTime today) {
    return DateTime(
      today.year,
      today.month,
      today.day,
      timeSource.hour,
      timeSource.minute,
      0,
      0,
    );
  }

  /// Stage 1: Alert 30 minutes before class
  Future<void> _send30MinuteAlert({
    required CourseEntity course,
    required TimetableEntryEntity entry,
    required String location,
    DateTime? scheduledDate,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(
          entry.id ??
              "${entry.courseId}_${entry.startDate.millisecondsSinceEpoch}",
          30,
        ),
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
      schedule: scheduledDate != null
          ? NotificationCalendar.fromDate(
              date: scheduledDate,
              preciseAlarm: true,
            )
          : null,
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
    required CourseEntity course,
    required TimetableEntryEntity entry,
    required String location,
    DateTime? scheduledDate,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id ?? '', 15),
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
          "entry_id": entry.id,
          "course_id": course.id,
        },
        wakeUpScreen: true,
        criticalAlert: true,
        fullScreenIntent: true,
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/time.png',
        roundedLargeIcon: true,
      ),
      schedule: scheduledDate != null
          ? NotificationCalendar.fromDate(
              date: scheduledDate,
              preciseAlarm: true,
            )
          : null,
    );
  }

  /// Stage 3: Alert when class is starting
  Future<void> _sendClassStartingAlert({
    required CourseEntity course,
    required TimetableEntryEntity entry,
    required String location,
    DateTime? scheduledDate,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id ?? '', 0),
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
      schedule: scheduledDate != null
          ? NotificationCalendar.fromDate(
              date: scheduledDate,
              preciseAlarm: true,
            )
          : null,
      actionButtons: [],
    );
  }

  /// Stage 4: Show status notification during class
  Future<void> _sendClassInProgressAlert({
    required CourseEntity course,
    required TimetableEntryEntity entry,
    required String location,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? scheduledDate,
  }) async {
    final effectiveNow = scheduledDate ?? DateTime.now();
    final elapsed = effectiveNow.difference(startTime);
    final totalDuration = endTime.difference(startTime).inMinutes;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateNotificationId(entry.id ?? '', -1),
        channelKey: 'course_alerts',
        title: '${course.courseName} is in progress',
        body: '📍 $location\n👨‍🏫 ${course.instructor}',
        summary:
            'Ends at ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')} ($totalDuration mins total)',
        actionType: ActionType.KeepOnTop,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Status,
        locked: true,
        autoDismissible: false,
        backgroundColor: course.color,
        color: Colors.black,
        showWhen: true,
        // The chronometer will count up from the start of the class
        chronometer: elapsed,
        payload: {},
        displayOnForeground: true,
        largeIcon: 'asset://assets/icons/timer.png',
        roundedLargeIcon: true,
      ),
      schedule: scheduledDate != null
          ? NotificationCalendar.fromDate(
              date: scheduledDate,
              preciseAlarm: true,
            )
          : null,
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
  /// Uses a combined string hash to prevent numerical collisions between stages.
  int _generateNotificationId(String entryId, int stage) {
    // We combine the ID and stage into a unique string before hashing.
    // This ensures 'ID1_stage15' and 'ID1_stage30' have completely uncorrelated hashes.
    return (entryId + stage.toString()).hashCode.abs() % 2147483647;
  }
}
