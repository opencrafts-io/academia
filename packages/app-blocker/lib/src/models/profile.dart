import 'schedule.dart';

/// A named group of blocked apps with associated schedules.
class BlockProfile {
  /// Creates a [BlockProfile] instance.
  const BlockProfile({
    required this.id,
    required this.name,
    required this.appIdentifiers,
    this.schedules = const [],
    this.isActive = false,
  });

  /// Unique identifier for this profile.
  final String id;

  /// Human-readable name (e.g., "Work Mode", "Sleep Mode").
  final String name;

  /// List of app identifiers to block when this profile is active.
  final List<String> appIdentifiers;

  /// Schedules associated with this profile.
  final List<BlockSchedule> schedules;

  /// Whether this profile is currently active.
  final bool isActive;

  /// Creates a copy with the given fields replaced.
  BlockProfile copyWith({
    String? id,
    String? name,
    List<String>? appIdentifiers,
    List<BlockSchedule>? schedules,
    bool? isActive,
  }) {
    return BlockProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      appIdentifiers: appIdentifiers ?? this.appIdentifiers,
      schedules: schedules ?? this.schedules,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Creates a [BlockProfile] from a map.
  factory BlockProfile.fromMap(Map<String, dynamic> map) {
    return BlockProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      appIdentifiers: List<String>.from(map['appIdentifiers'] as List),
      schedules:
          (map['schedules'] as List?)
              ?.map(
                (e) =>
                    BlockSchedule.fromMap(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          const [],
      isActive: map['isActive'] as bool? ?? false,
    );
  }

  /// Converts this instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appIdentifiers': appIdentifiers,
      'schedules': schedules.map((s) => s.toMap()).toList(),
      'isActive': isActive,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockProfile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'BlockProfile(id: $id, name: $name, isActive: $isActive)';
}
