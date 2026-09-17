/// Cross-platform app blocking plugin for Flutter.
///
/// Block applications on Android (custom block screen) and iOS (Screen Time Shield).
/// Supports scheduling, focus profiles, and real-time blocking events.
library;

export 'src/app_blocker.dart';
export 'src/app_blocker_platform_interface.dart';
export 'src/exceptions/app_blocker_exception.dart';
export 'src/models/app_info.dart';
export 'src/models/block_event.dart';
export 'src/models/block_status.dart';
export 'src/models/blocker_capabilities.dart';
export 'src/models/block_screen_config.dart';
export 'src/models/permission_status.dart';
export 'src/models/profile.dart';
export 'src/models/schedule.dart';
