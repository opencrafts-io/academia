import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigModel extends RemoteConfigEntity {
  const RemoteConfigModel({
    required super.key,
    required super.value,
    required super.source,
    required super.lastFetchTime,
    required super.lastActivatedTime,
    super.isStale,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigModel(
      key: json['key'] as String,
      value: json['value'],
      source: json['source'] as String,
      lastFetchTime: DateTime.parse(json['lastFetchTime'] as String),
      lastActivatedTime: DateTime.parse(json['lastActivatedTime'] as String),
      isStale: json['isStale'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'source': source,
      'lastFetchTime': lastFetchTime.toIso8601String(),
      'lastActivatedTime': lastActivatedTime.toIso8601String(),
      'isStale': isStale,
    };
  }

  factory RemoteConfigModel.fromEntity(RemoteConfigEntity entity) {
    return RemoteConfigModel(
      key: entity.key,
      value: entity.value,
      source: entity.source,
      lastFetchTime: entity.lastFetchTime,
      lastActivatedTime: entity.lastActivatedTime,
      isStale: entity.isStale,
    );
  }

  RemoteConfigEntity toEntity() {
    return RemoteConfigEntity(
      key: key,
      value: value,
      source: source,
      lastFetchTime: lastFetchTime,
      lastActivatedTime: lastActivatedTime,
      isStale: isStale,
    );
  }
}

