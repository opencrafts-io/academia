import 'package:flutter/services.dart';

import 'app_blocker_platform_interface.dart';
import 'constants.dart';
import 'exceptions/app_blocker_exception.dart';
import 'models/app_info.dart';
import 'models/block_event.dart';
import 'models/block_status.dart';
import 'models/blocker_capabilities.dart';
import 'models/block_screen_config.dart';
import 'models/permission_status.dart';
import 'models/profile.dart';
import 'models/schedule.dart';

/// Method channel implementation of [AppBlockerPlatform].
class MethodChannelAppBlocker extends AppBlockerPlatform {
  final MethodChannel _methodChannel = const MethodChannel(
    AppBlockerConstants.methodChannel,
  );

  final EventChannel _eventChannel = const EventChannel(
    AppBlockerConstants.eventChannel,
  );

  Stream<BlockEvent>? _blockEventStream;

  // -- Capabilities --

  @override
  Future<BlockerCapabilities> getCapabilities() async {
    final result = await _invokeMethod<Map>(
      AppBlockerConstants.getCapabilities,
    );
    return BlockerCapabilities.fromMap(Map<String, dynamic>.from(result!));
  }

  // -- Permissions --

  @override
  Future<BlockerPermissionStatus> checkPermission() async {
    final result = await _invokeMethod<String>(
      AppBlockerConstants.checkPermission,
    );
    return _parsePermissionStatus(result!);
  }

  @override
  Future<BlockerPermissionStatus> requestPermission() async {
    final result = await _invokeMethod<String>(
      AppBlockerConstants.requestPermission,
    );
    return _parsePermissionStatus(result!);
  }

  // -- App Discovery --

  @override
  Future<List<AppInfo>> getApps() async {
    final result = await _invokeMethod<List>(AppBlockerConstants.getApps);
    if (result == null) return [];
    return result
        .map((e) => AppInfo.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  // -- Blocking --

  @override
  Future<void> blockApps(List<String> appIdentifiers) async {
    await _invokeMethod<void>(AppBlockerConstants.blockApps, {
      'identifiers': appIdentifiers,
    });
  }

  @override
  Future<void> blockAll() async {
    await _invokeMethod<void>(AppBlockerConstants.blockAll);
  }

  @override
  Future<void> unblockApps(List<String> appIdentifiers) async {
    await _invokeMethod<void>(AppBlockerConstants.unblockApps, {
      'identifiers': appIdentifiers,
    });
  }

  @override
  Future<void> unblockAll() async {
    await _invokeMethod<void>(AppBlockerConstants.unblockAll);
  }

  @override
  Future<List<String>> getBlockedApps() async {
    final result = await _invokeMethod<List>(
      AppBlockerConstants.getBlockedApps,
    );
    if (result == null) return [];
    return List<String>.from(result);
  }

  @override
  Future<BlockStatus> getAppStatus(String appIdentifier) async {
    final result = await _invokeMethod<String>(
      AppBlockerConstants.getAppStatus,
      {'identifier': appIdentifier},
    );
    return BlockStatus.values.byName(result!);
  }

  // -- Events --

  @override
  Stream<BlockEvent> get onBlockEvent {
    _blockEventStream ??= _eventChannel.receiveBroadcastStream().map((event) {
      return BlockEvent.fromMap(Map<String, dynamic>.from(event as Map));
    });
    return _blockEventStream!;
  }

  // -- Block Screen Config --

  @override
  Future<void> setBlockScreenConfig(BlockScreenConfig config) async {
    await _invokeMethod<void>(
      AppBlockerConstants.setBlockScreenConfig,
      config.toMap(),
    );
  }

  @override
  Future<BlockScreenConfig?> getBlockScreenConfig() async {
    final result = await _invokeMethod<Map>(
      AppBlockerConstants.getBlockScreenConfig,
    );
    if (result == null) return null;
    return BlockScreenConfig.fromMap(Map<String, dynamic>.from(result));
  }

  // -- Scheduling --

  @override
  Future<void> addSchedule(BlockSchedule schedule) async {
    await _invokeMethod<void>(
      AppBlockerConstants.addSchedule,
      schedule.toMap(),
    );
  }

  @override
  Future<void> updateSchedule(BlockSchedule schedule) async {
    await _invokeMethod<void>(
      AppBlockerConstants.updateSchedule,
      schedule.toMap(),
    );
  }

  @override
  Future<void> removeSchedule(String scheduleId) async {
    await _invokeMethod<void>(AppBlockerConstants.removeSchedule, {
      'id': scheduleId,
    });
  }

  @override
  Future<List<BlockSchedule>> getSchedules() async {
    final result = await _invokeMethod<List>(AppBlockerConstants.getSchedules);
    if (result == null) return [];
    return result
        .map((e) => BlockSchedule.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> enableSchedule(String scheduleId) async {
    await _invokeMethod<void>(AppBlockerConstants.enableSchedule, {
      'id': scheduleId,
    });
  }

  @override
  Future<void> disableSchedule(String scheduleId) async {
    await _invokeMethod<void>(AppBlockerConstants.disableSchedule, {
      'id': scheduleId,
    });
  }

  // -- Profiles --

  @override
  Future<void> createProfile(BlockProfile profile) async {
    await _invokeMethod<void>(
      AppBlockerConstants.createProfile,
      profile.toMap(),
    );
  }

  @override
  Future<void> updateProfile(BlockProfile profile) async {
    await _invokeMethod<void>(
      AppBlockerConstants.updateProfile,
      profile.toMap(),
    );
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    await _invokeMethod<void>(AppBlockerConstants.deleteProfile, {
      'id': profileId,
    });
  }

  @override
  Future<List<BlockProfile>> getProfiles() async {
    final result = await _invokeMethod<List>(AppBlockerConstants.getProfiles);
    if (result == null) return [];
    return result
        .map((e) => BlockProfile.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> activateProfile(String profileId) async {
    await _invokeMethod<void>(AppBlockerConstants.activateProfile, {
      'id': profileId,
    });
  }

  @override
  Future<void> deactivateProfile(String profileId) async {
    await _invokeMethod<void>(AppBlockerConstants.deactivateProfile, {
      'id': profileId,
    });
  }

  @override
  Future<BlockProfile?> getActiveProfile() async {
    final result = await _invokeMethod<Map?>(
      AppBlockerConstants.getActiveProfile,
    );
    if (result == null) return null;
    return BlockProfile.fromMap(Map<String, dynamic>.from(result));
  }

  // -- Helpers --

  /// Invokes a method on the platform channel with proper error translation.
  Future<T?> _invokeMethod<T>(String method, [dynamic arguments]) async {
    try {
      return await _methodChannel.invokeMethod<T>(method, arguments);
    } on PlatformException catch (e) {
      throw _translateException(e);
    }
  }

  /// Translates a [PlatformException] to a typed [AppBlockerException].
  AppBlockerException _translateException(PlatformException e) {
    switch (e.code) {
      case AppBlockerConstants.errorPermissionDenied:
        return PermissionDeniedException(
          message: e.message ?? 'Permission denied.',
        );
      case AppBlockerConstants.errorPermissionRestricted:
        return PermissionRestrictedException(
          message: e.message ?? 'Permission restricted.',
        );
      case AppBlockerConstants.errorServiceUnavailable:
        return ServiceUnavailableException(
          message: e.message ?? 'Service unavailable.',
        );
      case AppBlockerConstants.errorPlatformUnsupported:
        return PlatformUnsupportedException(
          message: e.message ?? 'Platform unsupported.',
        );
      case AppBlockerConstants.errorScheduleConflict:
        return ScheduleConflictException(
          message: e.message ?? 'Schedule conflict.',
        );
      case AppBlockerConstants.errorProfileNotFound:
        return ProfileNotFoundException(
          message: e.message ?? 'Profile not found.',
        );
      case AppBlockerConstants.errorInvalidConfig:
        return InvalidConfigException(
          message: e.message ?? 'Invalid configuration.',
        );
      default:
        return ServiceUnavailableException(
          message: e.message ?? 'Unknown error: ${e.code}',
        );
    }
  }

  BlockerPermissionStatus _parsePermissionStatus(String status) {
    switch (status) {
      case 'granted':
        return BlockerPermissionStatus.granted;
      case 'restricted':
        return BlockerPermissionStatus.restricted;
      default:
        return BlockerPermissionStatus.denied;
    }
  }
}
