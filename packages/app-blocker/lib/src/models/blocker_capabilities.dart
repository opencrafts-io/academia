/// Describes the capabilities available on the current platform.
class BlockerCapabilities {
  /// Creates a [BlockerCapabilities] instance.
  const BlockerCapabilities({
    required this.canBlockApps,
    required this.canCustomizeBlockScreen,
    required this.canUseSystemShield,
    required this.canSchedule,
    required this.canGetInstalledApps,
    required this.canShowActivityPicker,
  });

  /// Whether the platform supports app blocking.
  final bool canBlockApps;

  /// Whether the platform supports customizing the block screen shown when a blocked app is opened.
  ///
  /// `true` on Android, `false` on iOS.
  final bool canCustomizeBlockScreen;

  /// Whether the platform uses system-level shields (Screen Time API).
  ///
  /// `true` on iOS, `false` on Android.
  final bool canUseSystemShield;

  /// Whether scheduling is supported.
  ///
  /// `true` on Android, `false` on iOS.
  final bool canSchedule;

  /// Whether the platform can list installed apps.
  ///
  /// `true` on Android, `false` on iOS.
  final bool canGetInstalledApps;

  /// Whether the platform can show a native activity picker.
  ///
  /// `true` on iOS (FamilyActivityPicker), `false` on Android.
  final bool canShowActivityPicker;

  /// Creates a [BlockerCapabilities] from a map.
  factory BlockerCapabilities.fromMap(Map<String, dynamic> map) {
    return BlockerCapabilities(
      canBlockApps: map['canBlockApps'] as bool? ?? false,
      canCustomizeBlockScreen: map['canCustomizeBlockScreen'] as bool? ?? false,
      canUseSystemShield: map['canUseSystemShield'] as bool? ?? false,
      canSchedule: map['canSchedule'] as bool? ?? false,
      canGetInstalledApps: map['canGetInstalledApps'] as bool? ?? false,
      canShowActivityPicker: map['canShowActivityPicker'] as bool? ?? false,
    );
  }

  @override
  String toString() =>
      'BlockerCapabilities(canBlockApps: $canBlockApps, canCustomizeBlockScreen: $canCustomizeBlockScreen, '
      'canUseSystemShield: $canUseSystemShield, canSchedule: $canSchedule)';
}
