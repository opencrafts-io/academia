import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Type definition for a migration step
typedef MigrationStep = Future<void> Function();

/// ------------------------------------------------------------
/// NotificationChannelMigration
///
/// Entry point used at app startup.
/// Responsible for running all pending notification channel
/// migrations in sequence.
/// ------------------------------------------------------------
class NotificationChannelMigration {
  static const int targetVersion = 2;

  static Future<void> run() async {
    final runner = NotificationChannelMigrationRunner(
      targetVersion: targetVersion,
      steps: {2: NotificationChannelMigrationSteps.v2},
    );

    await runner.run();
  }
}

/// ------------------------------------------------------------
/// NotificationChannelMigrationRunner
///
/// Handles:
/// - reading stored version
/// - executing missing migration steps in order
/// - persisting updated version after each step
/// ------------------------------------------------------------
class NotificationChannelMigrationRunner {
  final int targetVersion;
  final Map<int, MigrationStep> steps;

  NotificationChannelMigrationRunner({
    required this.targetVersion,
    required this.steps,
  });

  Future<void> run() async {
    final prefs = await SharedPreferences.getInstance();

    final currentVersion = prefs.getInt('notification_channel_version') ?? 1;

    if (currentVersion >= targetVersion) return;

    for (
      int version = currentVersion + 1;
      version <= targetVersion;
      version++
    ) {
      final step = steps[version];

      if (step != null) {
        await step();
      }

      await prefs.setInt('notification_channel_version', version);
    }
  }
}

/// ------------------------------------------------------------
/// NotificationChannelMigrationSteps
///
/// Contains actual migration logic per version.
/// Each method represents a schema upgrade step.
/// ------------------------------------------------------------
class NotificationChannelMigrationSteps {
  static final AwesomeNotifications _awesome = AwesomeNotifications();

  /// v2:
  /// Remove legacy notification channels from early versions
  static Future<void> v2() async {
    await _removeLegacyChannels();
  }

  /// Shared cleanup for old v1 channels
  static Future<void> _removeLegacyChannels() async {
    final legacyChannels = [
      'local_reminder_channel',
      'local_alert_channel',
      'local_update_channel',
      'course_alerts',
    ];

    for (final channel in legacyChannels) {
      await _awesome.removeChannel(channel);
    }
  }
}
