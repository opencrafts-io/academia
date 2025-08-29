import 'package:equatable/equatable.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object?> get props => [];
}

class RemoteConfigInitialState extends RemoteConfigState {
  const RemoteConfigInitialState();
}

class RemoteConfigLoadingState extends RemoteConfigState {
  const RemoteConfigLoadingState();
}

class RemoteConfigInitializedState extends RemoteConfigState {
  const RemoteConfigInitializedState();
}

class RemoteConfigFetchedState extends RemoteConfigState {
  const RemoteConfigFetchedState();
}

class StringValueLoadedState extends RemoteConfigState {
  final String key;
  final String value;

  const StringValueLoadedState({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class BoolValueLoadedState extends RemoteConfigState {
  final String key;
  final bool value;

  const BoolValueLoadedState({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class IntValueLoadedState extends RemoteConfigState {
  final String key;
  final int value;

  const IntValueLoadedState({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class DoubleValueLoadedState extends RemoteConfigState {
  final String key;
  final double value;

  const DoubleValueLoadedState({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class JsonValueLoadedState extends RemoteConfigState {
  final String key;
  final Map<String, dynamic> value;

  const JsonValueLoadedState({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class AllParametersLoadedState extends RemoteConfigState {
  final Map<String, dynamic> parameters;

  const AllParametersLoadedState({
    required this.parameters,
  });

  @override
  List<Object?> get props => [parameters];
}

class DefaultsSetState extends RemoteConfigState {
  const DefaultsSetState();
}

class SettingsLoadedState extends RemoteConfigState {
  final RemoteConfigSettingsEntity settings;

  const SettingsLoadedState({
    required this.settings,
  });

  @override
  List<Object?> get props => [settings];
}

class SettingsSetState extends RemoteConfigState {
  const SettingsSetState();
}

class InitializedStatusLoadedState extends RemoteConfigState {
  final bool isInitialized;

  const InitializedStatusLoadedState({
    required this.isInitialized,
  });

  @override
  List<Object?> get props => [isInitialized];
}

class LastFetchTimeLoadedState extends RemoteConfigState {
  final DateTime? lastFetchTime;

  const LastFetchTimeLoadedState({
    this.lastFetchTime,
  });

  @override
  List<Object?> get props => [lastFetchTime];
}

class LastActivatedTimeLoadedState extends RemoteConfigState {
  final DateTime? lastActivatedTime;

  const LastActivatedTimeLoadedState({
    this.lastActivatedTime,
  });

  @override
  List<Object?> get props => [lastActivatedTime];
}

class ConfigStaleStatusLoadedState extends RemoteConfigState {
  final bool isStale;

  const ConfigStaleStatusLoadedState({
    required this.isStale,
  });

  @override
  List<Object?> get props => [isStale];
}

class RemoteConfigErrorState extends RemoteConfigState {
  final String message;

  const RemoteConfigErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
