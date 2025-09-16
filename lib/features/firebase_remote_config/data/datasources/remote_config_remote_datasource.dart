import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:async'; // Added for Completer

class RemoteConfigRemoteDatasource {
  final Logger _logger = Logger();
  FirebaseRemoteConfig? _remoteConfig;
  bool _isInitialized = false;
  final Completer<void> _initializationCompleter = Completer<void>();

  /// Initialize Firebase Remote Config
  Future<Either<Failure, void>> initialize() async {
    try {
      // Get the Firebase Remote Config instance
      _remoteConfig = FirebaseRemoteConfig.instance;

      // Verify the instance is available
      if (_remoteConfig == null) {
        throw Exception('Firebase Remote Config instance is null');
      }

      // Set default settings
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Set default values
      await _remoteConfig!.setDefaults({
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

      _isInitialized = true;
      _initializationCompleter.complete();
      return right(null);
    } catch (e) {
      _logger.e('Failed to initialize Firebase Remote Config', error: e);
      _isInitialized = false;
      _remoteConfig = null;
      _initializationCompleter.completeError(e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to initialize remote config: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Wait for initialization to complete
  Future<void> _waitForInitialization() async {
    if (!_initializationCompleter.isCompleted) {
      await _initializationCompleter.future;
    }
  }

  /// Fetch and activate remote config values
  Future<Either<Failure, void>> fetchAndActivate() async {
    try {
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final success = await _remoteConfig!.fetchAndActivate();

      if (success) {
        return right(null);
      } else {
        throw Exception('Failed to fetch and activate remote config values');
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final value = _remoteConfig!.getString(key);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final value = _remoteConfig!.getBool(key);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final value = _remoteConfig!.getInt(key);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final value = _remoteConfig!.getDouble(key);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final jsonString = _remoteConfig!.getString(key);

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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final parameters = _remoteConfig!.getAll();
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      await _remoteConfig!.setDefaults(defaults);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final settings = _remoteConfig!.settings;
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      await _remoteConfig!.setConfigSettings(settings);
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

  /// Check if remote config is initialized
  Future<Either<Failure, bool>> isInitialized() async {
    return right(_isInitialized && _remoteConfig != null);
  }

  /// Get last fetch time
  Future<Either<Failure, DateTime?>> getLastFetchTime() async {
    try {
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final lastFetchTime = _remoteConfig!.lastFetchTime;
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      // Note: Firebase Remote Config doesn't provide last activated time directly
      // We'll use last fetch time as a proxy
      return right(_remoteConfig!.lastFetchTime);
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
      // Wait for initialization to complete
      await _waitForInitialization();
      
      if (!_isInitialized || _remoteConfig == null) {
        throw Exception('Remote Config not initialized');
      }

      final lastFetchTime = _remoteConfig!.lastFetchTime;
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
