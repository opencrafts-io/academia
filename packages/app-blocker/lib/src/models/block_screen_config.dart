import 'dart:ui';

/// Configuration for the Android block screen shown when a blocked app is opened.
///
/// This has no effect on iOS, where the system shield is used instead.
class BlockScreenConfig {
  /// Creates an [BlockScreenConfig] instance.
  const BlockScreenConfig({
    this.title,
    this.subtitle,
    this.message,
    this.backgroundColor,
    this.iconAssetPath,
  });

  /// The title text shown on the block screen.
  ///
  /// Defaults to "App Blocked" if not specified.
  final String? title;

  /// The subtitle text shown below the title.
  final String? subtitle;

  /// Additional message text shown on the block screen.
  final String? message;

  /// The background color of the block screen.
  ///
  /// Defaults to a dark semi-transparent color if not specified.
  final Color? backgroundColor;

  /// Path to a custom icon asset to display on the block screen.
  ///
  /// Should be a Flutter asset path (e.g., `assets/icons/lock.png`).
  final String? iconAssetPath;

  /// Creates an [BlockScreenConfig] from a map returned by the platform.
  factory BlockScreenConfig.fromMap(Map<String, dynamic> map) {
    return BlockScreenConfig(
      title: map['title'] as String?,
      subtitle: map['subtitle'] as String?,
      message: map['message'] as String?,
      backgroundColor: map['backgroundColor'] != null
          ? Color(map['backgroundColor'] as int)
          : null,
      iconAssetPath: map['iconAssetPath'] as String?,
    );
  }

  /// Converts this instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'message': message,
      'backgroundColor': backgroundColor?.toARGB32(),
      'iconAssetPath': iconAssetPath,
    };
  }

  @override
  String toString() => 'BlockScreenConfig(title: $title, subtitle: $subtitle)';
}
