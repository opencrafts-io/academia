import 'package:workmanager/workmanager.dart';

abstract class BackgroundTask {
  /// Unique identifier for this task type
  /// This will be used to register and match tasks
  String get taskName;

  /// Optional: Task tag for grouping related tasks
  String? get taskTag => null;

  /// The method that will be executed when the task runs
  /// Return true if task completed successfully, false otherwise
  Future<bool> execute(Map<String, dynamic>? inputData);

  /// Optional: Configure task constraints
  /// Override this to set custom constraints for your task
  BackgroundTaskConstraints get constraints =>
      const BackgroundTaskConstraints();

  /// Optional: Configure task execution frequency
  /// Override this to set custom frequency for periodic tasks
  Duration? get frequency => null;

  /// Optional: Initial delay before first execution
  Duration? get initialDelay => null;

  /// Optional: Existing work policy for one-time tasks
  ExistingWorkPolicy get existingWorkPolicy => ExistingWorkPolicy.keep;

  /// Optional: Input data to pass to the task
  Map<String, dynamic>? get inputData => null;

  /// Optional: Back-off policy for failed tasks
  BackoffPolicyConfig get backoffPolicy => const BackoffPolicyConfig();
}

/// Configuration for task constraints
class BackgroundTaskConstraints {
  final NetworkType networkType;
  final bool requiresBatteryNotLow;
  final bool requiresCharging;
  final bool requiresDeviceIdle;
  final bool requiresStorageNotLow;

  const BackgroundTaskConstraints({
    this.networkType = NetworkType.notRequired,
    this.requiresBatteryNotLow = false,
    this.requiresCharging = false,
    this.requiresDeviceIdle = false,
    this.requiresStorageNotLow = false,
  });

  Constraints toWorkManagerConstraints() {
    return Constraints(
      networkType: networkType,
      requiresBatteryNotLow: requiresBatteryNotLow,
      requiresCharging: requiresCharging,
      requiresDeviceIdle: requiresDeviceIdle,
      requiresStorageNotLow: requiresStorageNotLow,
    );
  }
}

/// Configuration for backoff policy
class BackoffPolicyConfig {
  final BackoffPolicy policy;
  final Duration delay;

  const BackoffPolicyConfig({
    this.policy = BackoffPolicy.exponential,
    this.delay = const Duration(minutes: 10),
  });
}
