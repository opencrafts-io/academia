import 'dart:convert';
import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteConfigLocalDatasource {
  final Logger _logger = Logger();
  static const String _configCacheKey = 'remote_config_cache';
  static const String _lastFetchTimeKey = 'remote_config_last_fetch';
  static const String _lastActivatedTimeKey = 'remote_config_last_activated';
  static const String _settingsKey = 'remote_config_settings';

  /// Cache remote config parameters locally
  Future<Either<Failure, void>> cacheConfig(Map<String, dynamic> config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = jsonEncode(config);
      await prefs.setString(_configCacheKey, configJson);
      await prefs.setString(_lastFetchTimeKey, DateTime.now().toIso8601String());
      
      return right(null);
    } catch (e) {
      _logger.e('Failed to cache remote config', error: e);
      return left(
        CacheFailure(
          message: 'Failed to cache remote config: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get cached remote config parameters
  Future<Either<Failure, Map<String, dynamic>>> getCachedConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = prefs.getString(_configCacheKey);
      
      if (configJson == null) {
        return right({});
      }

      final config = jsonDecode(configJson) as Map<String, dynamic>;
      return right(config);
    } catch (e) {
      _logger.e('Failed to get cached remote config', error: e);
      return left(
        CacheFailure(
          message: 'Failed to get cached remote config: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Cache last fetch time
  Future<Either<Failure, void>> cacheLastFetchTime(DateTime time) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastFetchTimeKey, time.toIso8601String());
      
      return right(null);
    } catch (e) {
      _logger.e('Failed to cache last fetch time', error: e);
      return left(
        CacheFailure(
          message: 'Failed to cache last fetch time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get cached last fetch time
  Future<Either<Failure, DateTime?>> getCachedLastFetchTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timeString = prefs.getString(_lastFetchTimeKey);
      
      if (timeString == null) {
        return right(null);
      }

      final time = DateTime.parse(timeString);
      return right(time);
    } catch (e) {
      _logger.e('Failed to get cached last fetch time', error: e);
      return left(
        CacheFailure(
          message: 'Failed to get cached last fetch time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Cache last activated time
  Future<Either<Failure, void>> cacheLastActivatedTime(DateTime time) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastActivatedTimeKey, time.toIso8601String());
      
      return right(null);
    } catch (e) {
      _logger.e('Failed to cache last activated time', error: e);
      return left(
        CacheFailure(
          message: 'Failed to cache last activated time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get cached last activated time
  Future<Either<Failure, DateTime?>> getCachedLastActivatedTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timeString = prefs.getString(_lastActivatedTimeKey);
      
      if (timeString == null) {
        return right(null);
      }

      final time = DateTime.parse(timeString);
      return right(time);
    } catch (e) {
      _logger.e('Failed to get cached last activated time', error: e);
      return left(
        CacheFailure(
          message: 'Failed to get cached last activated time: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Cache remote config settings
  Future<Either<Failure, void>> cacheSettings(RemoteConfigSettingsEntity settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = jsonEncode(settings.toJson());
      await prefs.setString(_settingsKey, settingsJson);
      
      return right(null);
    } catch (e) {
      _logger.e('Failed to cache remote config settings', error: e);
      return left(
        CacheFailure(
          message: 'Failed to cache remote config settings: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get cached remote config settings
  Future<Either<Failure, RemoteConfigSettingsEntity?>> getCachedSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);
      
      if (settingsJson == null) {
        return right(null);
      }

      final settingsMap = jsonDecode(settingsJson) as Map<String, dynamic>;
      final settings = RemoteConfigSettingsModel.fromJson(settingsMap);
      
      return right(settings);
    } catch (e) {
      _logger.e('Failed to get cached remote config settings', error: e);
      return left(
        CacheFailure(
          message: 'Failed to get cached remote config settings: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Clear all cached remote config data
  Future<Either<Failure, void>> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_configCacheKey);
      await prefs.remove(_lastFetchTimeKey);
      await prefs.remove(_lastActivatedTimeKey);
      await prefs.remove(_settingsKey);
      
      return right(null);
    } catch (e) {
      _logger.e('Failed to clear cache', error: e);
      return left(
        CacheFailure(
          message: 'Failed to clear cache: ${e.toString()}',
          error: e,
        ),
      );
    }
  }
}

