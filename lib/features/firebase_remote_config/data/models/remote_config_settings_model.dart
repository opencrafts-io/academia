import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigSettingsModel extends RemoteConfigSettingsEntity {
  const RemoteConfigSettingsModel({
    required super.fetchTimeout,
    required super.minimumFetchInterval,
    super.isDeveloperMode,
  });

  factory RemoteConfigSettingsModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigSettingsModel(
      fetchTimeout: Duration(milliseconds: json['fetchTimeout'] as int),
      minimumFetchInterval: Duration(milliseconds: json['minimumFetchInterval'] as int),
      isDeveloperMode: json['isDeveloperMode'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fetchTimeout': fetchTimeout.inMilliseconds,
      'minimumFetchInterval': minimumFetchInterval.inMilliseconds,
      'isDeveloperMode': isDeveloperMode,
    };
  }

  factory RemoteConfigSettingsModel.fromEntity(RemoteConfigSettingsEntity entity) {
    return RemoteConfigSettingsModel(
      fetchTimeout: entity.fetchTimeout,
      minimumFetchInterval: entity.minimumFetchInterval,
      isDeveloperMode: entity.isDeveloperMode,
    );
  }

  RemoteConfigSettingsEntity toEntity() {
    return RemoteConfigSettingsEntity(
      fetchTimeout: fetchTimeout,
      minimumFetchInterval: minimumFetchInterval,
      isDeveloperMode: isDeveloperMode,
    );
  }
}
