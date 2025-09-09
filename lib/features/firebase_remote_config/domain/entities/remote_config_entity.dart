import 'package:equatable/equatable.dart';

class RemoteConfigEntity extends Equatable {
  final String key;
  final dynamic value;
  final String source;
  final DateTime lastFetchTime;
  final DateTime lastActivatedTime;
  final bool isStale;

  const RemoteConfigEntity({
    required this.key,
    required this.value,
    required this.source,
    required this.lastFetchTime,
    required this.lastActivatedTime,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [
        key,
        value,
        source,
        lastFetchTime,
        lastActivatedTime,
        isStale,
      ];

  RemoteConfigEntity copyWith({
    String? key,
    dynamic value,
    String? source,
    DateTime? lastFetchTime,
    DateTime? lastActivatedTime,
    bool? isStale,
  }) {
    return RemoteConfigEntity(
      key: key ?? this.key,
      value: value ?? this.value,
      source: source ?? this.source,
      lastFetchTime: lastFetchTime ?? this.lastFetchTime,
      lastActivatedTime: lastActivatedTime ?? this.lastActivatedTime,
      isStale: isStale ?? this.isStale,
    );
  }
}

class RemoteConfigSettingsEntity extends Equatable {
  final Duration fetchTimeout;
  final Duration minimumFetchInterval;
  final bool isDeveloperMode;

  const RemoteConfigSettingsEntity({
    required this.fetchTimeout,
    required this.minimumFetchInterval,
    this.isDeveloperMode = false,
  });

  @override
  List<Object?> get props => [
        fetchTimeout,
        minimumFetchInterval,
        isDeveloperMode,
      ];

  RemoteConfigSettingsEntity copyWith({
    Duration? fetchTimeout,
    Duration? minimumFetchInterval,
    bool? isDeveloperMode,
  }) {
    return RemoteConfigSettingsEntity(
      fetchTimeout: fetchTimeout ?? this.fetchTimeout,
      minimumFetchInterval: minimumFetchInterval ?? this.minimumFetchInterval,
      isDeveloperMode: isDeveloperMode ?? this.isDeveloperMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fetchTimeout': fetchTimeout.inMilliseconds,
      'minimumFetchInterval': minimumFetchInterval.inMilliseconds,
      'isDeveloperMode': isDeveloperMode,
    };
  }
}
