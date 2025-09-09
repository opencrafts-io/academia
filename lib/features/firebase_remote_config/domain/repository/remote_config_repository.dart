import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteConfigRepository {
  /// Initialize Firebase Remote Config
  Future<Either<Failure, void>> initialize();
  
  /// Fetch and activate remote config values
  Future<Either<Failure, void>> fetchAndActivate();
  
  /// Get a string value from remote config
  Future<Either<Failure, String>> getString(String key, {String defaultValue = ''});
  
  /// Get a boolean value from remote config
  Future<Either<Failure, bool>> getBool(String key, {bool defaultValue = false});
  
  /// Get an integer value from remote config
  Future<Either<Failure, int>> getInt(String key, {int defaultValue = 0});
  
  /// Get a double value from remote config
  Future<Either<Failure, double>> getDouble(String key, {double defaultValue = 0.0});
  
  /// Get a JSON value from remote config
  Future<Either<Failure, Map<String, dynamic>>> getJson(String key, {Map<String, dynamic>? defaultValue});
  
  /// Get all remote config parameters
  Future<Either<Failure, Map<String, dynamic>>> getAllParameters();
  
  /// Set default values for remote config parameters
  Future<Either<Failure, void>> setDefaults(Map<String, dynamic> defaults);
  
  /// Get remote config settings
  Future<Either<Failure, RemoteConfigSettingsEntity>> getSettings();
  
  /// Set remote config settings
  Future<Either<Failure, void>> setSettings(RemoteConfigSettingsEntity settings);
  
  /// Check if remote config is initialized
  Future<Either<Failure, bool>> isInitialized();
  
  /// Get last fetch time
  Future<Either<Failure, DateTime?>> getLastFetchTime();
  
  /// Get last activated time
  Future<Either<Failure, DateTime?>> getLastActivatedTime();
  
  /// Check if config is stale
  Future<Either<Failure, bool>> isConfigStale();
}
