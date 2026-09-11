import 'dart:typed_data';

/// Information about an installed application.
class AppInfo {
  /// Creates an [AppInfo] instance.
  const AppInfo({
    required this.packageName,
    required this.appName,
    this.icon,
    this.isSystemApp = false,
  });

  /// The package identifier.
  ///
  /// On Android, this is the package name (e.g., `com.example.app`).
  /// On iOS, this is an opaque token string from FamilyControls.
  final String packageName;

  /// The display name of the application.
  final String appName;

  /// The app icon as PNG bytes.
  ///
  /// Available on Android only. Returns `null` on iOS.
  final Uint8List? icon;

  /// Whether this is a system application.
  final bool isSystemApp;

  /// Creates an [AppInfo] from a map (used for platform channel deserialization).
  factory AppInfo.fromMap(Map<String, dynamic> map) {
    return AppInfo(
      packageName: map['packageName'] as String,
      appName: map['appName'] as String,
      icon: map['icon'] as Uint8List?,
      isSystemApp: map['isSystemApp'] as bool? ?? false,
    );
  }

  /// Converts this instance to a map (used for platform channel serialization).
  Map<String, dynamic> toMap() {
    return {
      'packageName': packageName,
      'appName': appName,
      'icon': icon,
      'isSystemApp': isSystemApp,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppInfo &&
          runtimeType == other.runtimeType &&
          packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;

  @override
  String toString() => 'AppInfo(packageName: $packageName, appName: $appName)';
}
