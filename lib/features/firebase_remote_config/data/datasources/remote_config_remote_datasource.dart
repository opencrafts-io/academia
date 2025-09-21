import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:async'; // Added for Completer

class RemoteConfigRemoteDatasource {
  final Logger _logger = Logger();
  FirebaseRemoteConfig remoteConfig;

  RemoteConfigRemoteDatasource({required this.remoteConfig});

  /// Initialize Firebase Remote Config
  Future<Either<Failure, void>> initialize() async {
    try {
      // Set default values
      await remoteConfig.setDefaults({
        'welcome_message': 'Welcome to Academia!',
        'new_ui_enabled': false,
        'beta_features_enabled': false,
        'max_retry_attempts': 3,
        'timeout_duration': 30.0,
        'user_preferences': jsonEncode({
          'theme': 'light',
          'language': 'en',
          'notifications_enabled': true,
        }),
      });

      // Set default settings
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );

      _logger.d("Initialized flutter remote config");

      return right(null);
    } catch (e) {
      _logger.e('Failed to initialize Firebase Remote Config', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to initialize remote config: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Fetch and activate remote config values
  Future<Either<Failure, void>> fetchAndActivate() async {
    try {
      final success = await remoteConfig.fetchAndActivate();
      _logger.d("Remote config fetch and activated: $success");
      if (success) {
        return right(null);
      } else {
        return right(null);
      }
    } catch (e) {
      _logger.e('Failed to fetch and activate remote config', error: e);
      return left(
        RemoteConfigFailure(
          message:
              'Failed to fetch and activate remote config: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get a string value from remote config
  Future<Either<Failure, String>> getString(
    String key, {
    String defaultValue = '',
  }) async {
    try {
      final value = remoteConfig.getString(key);
      return right(value);
    } catch (e) {
      _logger.e('Failed to get string value for key "$key"', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get string value: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get a boolean value from remote config
  Future<Either<Failure, bool>> getBool(
    String key, {
    bool defaultValue = false,
  }) async {
    try {
      final value = remoteConfig.getBool(key);
      return right(value);
    } catch (e) {
      _logger.e('Failed to get boolean value for key "$key"', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get boolean value: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get an integer value from remote config
  Future<Either<Failure, int>> getInt(
    String key, {
    int defaultValue = 0,
  }) async {
    try {
      final value = remoteConfig.getInt(key);
      return right(value);
    } catch (e) {
      _logger.e('Failed to get integer value for key "$key"', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get integer value: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get a double value from remote config
  Future<Either<Failure, double>> getDouble(
    String key, {
    double defaultValue = 0.0,
  }) async {
    try {
      final value = remoteConfig.getDouble(key);
      return right(value);
    } catch (e) {
      _logger.e('Failed to get double value for key "$key"', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get double value: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get a JSON value from remote config
  Future<Either<Failure, Map<String, dynamic>>> getJson(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) async {
    try {
      final jsonString = remoteConfig.getString(key);

      if (jsonString.isEmpty) {
        return right(defaultValue ?? {});
      }
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      return right(jsonData);
    } catch (e) {
      _logger.e('Failed to get JSON value for key "$key"', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get JSON value: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get all remote config parameters
  Future<Either<Failure, Map<String, dynamic>>> getAllParameters() async {
    try {
      final parameters = remoteConfig.getAll();
      final result = <String, dynamic>{};

      for (final entry in parameters.entries) {
        result[entry.key] = entry.value.asString();
      }

      return right(result);
    } catch (e) {
      _logger.e('Failed to get all parameters', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get all parameters: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Set default values for remote config parameters
  Future<Either<Failure, void>> setDefaults(
    Map<String, dynamic> defaults,
  ) async {
    try {
      await remoteConfig.setDefaults(defaults);
      return right(null);
    } catch (e) {
      _logger.e('Failed to set defaults', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to set defaults: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get remote config settings
  Future<Either<Failure, RemoteConfigSettings>> getSettings() async {
    try {
      final settings = remoteConfig.settings;
      return right(settings);
    } catch (e) {
      _logger.e('Failed to get settings', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get settings: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Set remote config settings
  Future<Either<Failure, void>> setSettings(
    RemoteConfigSettings settings,
  ) async {
    try {
      await remoteConfig.setConfigSettings(settings);
      return right(null);
    } catch (e) {
      _logger.e('Failed to set settings', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to set settings: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get last fetch time
  Future<Either<Failure, DateTime?>> getLastFetchTime() async {
    try {
      final lastFetchTime = remoteConfig.lastFetchTime;
      return right(lastFetchTime);
    } catch (e) {
      _logger.e('Failed to get last fetch time', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get last fetch time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get last activated time
  Future<Either<Failure, DateTime?>> getLastActivatedTime() async {
    try {
      // Note: Firebase Remote Config doesn't provide last activated time directly
      // We'll use last fetch time as a proxy
      return right(remoteConfig.lastFetchTime);
    } catch (e) {
      _logger.e('Failed to get last activated time', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to get last activated time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Check if config is stale
  Future<Either<Failure, bool>> isConfigStale() async {
    try {
      final lastFetchTime = remoteConfig.lastFetchTime;
      final now = DateTime.now();
      final difference = now.difference(lastFetchTime);
      final isStale = difference.inHours > 1; // Consider stale after 1 hour

      return right(isStale);
    } catch (e) {
      _logger.e('Failed to check if config is stale', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to check if config is stale: ${e.toString()}',
          error: e,
        ),
      );
    }
  }
}

/// Custom failure for remote config operations
class RemoteConfigFailure extends Failure {
  final String _message;
  final Object? _error;

  RemoteConfigFailure({required super.message, Object? error})
    : _message = message,
      _error = error,
      super(error: error ?? Object());

  @override
  String get message => _message;

  @override
  Object get error => _error ?? Object();
}
