import 'package:equatable/equatable.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';

abstract class RemoteConfigEvent extends Equatable {
  const RemoteConfigEvent();

  @override
  List<Object?> get props => [];
}

class InitializeRemoteConfigEvent extends RemoteConfigEvent {
  const InitializeRemoteConfigEvent();
}

class FetchAndActivateEvent extends RemoteConfigEvent {
  const FetchAndActivateEvent();
}

class GetStringEvent extends RemoteConfigEvent {
  final String key;
  final String defaultValue;

  const GetStringEvent({
    required this.key,
    this.defaultValue = '',
  });

  @override
  List<Object?> get props => [key, defaultValue];
}

class GetBoolEvent extends RemoteConfigEvent {
  final String key;
  final bool defaultValue;

  const GetBoolEvent({
    required this.key,
    this.defaultValue = false,
  });

  @override
  List<Object?> get props => [key, defaultValue];
}

class GetIntEvent extends RemoteConfigEvent {
  final String key;
  final int defaultValue;

  const GetIntEvent({
    required this.key,
    this.defaultValue = 0,
  });

  @override
  List<Object?> get props => [key, defaultValue];
}

class GetDoubleEvent extends RemoteConfigEvent {
  final String key;
  final double defaultValue;

  const GetDoubleEvent({
    required this.key,
    this.defaultValue = 0.0,
  });

  @override
  List<Object?> get props => [key, defaultValue];
}

class GetJsonEvent extends RemoteConfigEvent {
  final String key;
  final Map<String, dynamic>? defaultValue;

  const GetJsonEvent({
    required this.key,
    this.defaultValue,
  });

  @override
  List<Object?> get props => [key, defaultValue];
}

class GetAllParametersEvent extends RemoteConfigEvent {
  const GetAllParametersEvent();
}

class SetDefaultsEvent extends RemoteConfigEvent {
  final Map<String, dynamic> defaults;

  const SetDefaultsEvent({required this.defaults});

  @override
  List<Object?> get props => [defaults];
}

class GetSettingsEvent extends RemoteConfigEvent {
  const GetSettingsEvent();
}

class SetSettingsEvent extends RemoteConfigEvent {
  final RemoteConfigSettingsEntity settings;

  const SetSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class CheckInitializedEvent extends RemoteConfigEvent {
  const CheckInitializedEvent();
}

class GetLastFetchTimeEvent extends RemoteConfigEvent {
  const GetLastFetchTimeEvent();
}

class GetLastActivatedTimeEvent extends RemoteConfigEvent {
  const GetLastActivatedTimeEvent();
}

class CheckConfigStaleEvent extends RemoteConfigEvent {
  const CheckConfigStaleEvent();
}
