import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigRemoteDatasource remoteDatasource;
  final RemoteConfigLocalDatasource localDatasource;
  final Logger _logger = Logger();

  RemoteConfigRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, void>> initialize() async {
    try {
      // Initialize remote datasource
      final remoteResult = await remoteDatasource.initialize();

      return await remoteResult.fold(
        (failure) async {
          _logger.w(
            'Remote config initialization failed'
            '\nWill default to provided defaults',
          );
          return left(failure);
        },
        (_) async {
          // Cache initial settings
          final settingsResult = await remoteDatasource.getSettings();
          return settingsResult.fold(
            (failure) => left(failure),
            (settings) => right(null),
          );
        },
      );
    } catch (e) {
      _logger.e(
        'Exception while attempting to initialize remote config',
        error: e,
      );
      return left(
        RemoteConfigFailure(
          message: 'Failed to initialize repository: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> fetchAndActivate() async {
    try {
      final result = await remoteDatasource.fetchAndActivate();

      return result.fold((failure) async {
        _logger.w(
          'Failed to fetch and activate remote config: ${failure.message}',
        );
        return right(null);
      }, (_) => right(null));
    } catch (e) {
      _logger.e('Failed to fetch and activate remote config', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to fetch and activate: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getString(
    String key, {
    String defaultValue = '',
  }) async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getString(
        key,
        defaultValue: defaultValue,
      );

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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

  @override
  Future<Either<Failure, bool>> getBool(
    String key, {
    bool defaultValue = false,
  }) async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getBool(
        key,
        defaultValue: defaultValue,
      );

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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

  @override
  Future<Either<Failure, int>> getInt(
    String key, {
    int defaultValue = 0,
  }) async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getInt(
        key,
        defaultValue: defaultValue,
      );

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedConfig();
        return cachedResult.fold((cacheFailure) => left(failure), (
          cachedConfig,
        ) {
          final value = cachedConfig[key] is int
              ? cachedConfig[key] as int
              : defaultValue;
          return right(value);
        });
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, double>> getDouble(
    String key, {
    double defaultValue = 0.0,
  }) async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getDouble(
        key,
        defaultValue: defaultValue,
      );

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedConfig();
        return cachedResult.fold((cacheFailure) => left(failure), (
          cachedConfig,
        ) {
          final value = cachedConfig[key] is double
              ? cachedConfig[key] as double
              : defaultValue;
          return right(value);
        });
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> getJson(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getJson(
        key,
        defaultValue: defaultValue,
      );

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedConfig();
        return cachedResult.fold((cacheFailure) => left(failure), (
          cachedConfig,
        ) {
          final cachedValue = cachedConfig[key];
          Map<String, dynamic> value;

          if (cachedValue is String) {
            try {
              value = jsonDecode(cachedValue) as Map<String, dynamic>;
            } catch (e) {
              _logger.w(
                'Failed to parse cached JSON for key "$key", using default',
              );
              value = defaultValue ?? {};
            }
          } else if (cachedValue is Map<String, dynamic>) {
            value = cachedValue;
          } else {
            value = defaultValue ?? {};
          }

          return right(value);
        });
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAllParameters() async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getAllParameters();

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedConfig();
        return cachedResult.fold((cacheFailure) => left(failure), (
          cachedConfig,
        ) {
          return right(cachedConfig);
        });
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, void>> setDefaults(
    Map<String, dynamic> defaults,
  ) async {
    try {
      final result = await remoteDatasource.setDefaults(defaults);

      return result.fold((failure) => left(failure), (_) async {
        // Also cache the defaults locally
        await localDatasource.cacheConfig(defaults);
        return right(null);
      });
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

  @override
  Future<Either<Failure, RemoteConfigSettingsEntity>> getSettings() async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getSettings();

      return remoteResult.fold(
        (failure) async {
          // Fallback to cached value
          final cachedResult = await localDatasource.getCachedSettings();
          return cachedResult.fold((cacheFailure) => left(failure), (
            cachedSettings,
          ) {
            if (cachedSettings == null) {
              return left(failure);
            }
            return right(cachedSettings);
          });
        },
        (settings) {
          final settingsEntity = RemoteConfigSettingsModel(
            fetchTimeout: settings.fetchTimeout,
            minimumFetchInterval: settings.minimumFetchInterval,
            isDeveloperMode: false,
          );
          return right(settingsEntity);
        },
      );
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

  @override
  Future<Either<Failure, void>> setSettings(
    RemoteConfigSettingsEntity settings,
  ) async {
    try {
      final remoteSettings = RemoteConfigSettings(
        fetchTimeout: settings.fetchTimeout,
        minimumFetchInterval: settings.minimumFetchInterval,
      );

      final result = await remoteDatasource.setSettings(remoteSettings);

      return result.fold((failure) => left(failure), (_) async {
        // Also cache the settings locally
        await localDatasource.cacheSettings(settings);
        return right(null);
      });
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

  @override
  Future<Either<Failure, bool>> isInitialized() async {
    try {
      // final remoteResult = await remoteDatasource.isInitialized();
      return right(true);
    } catch (e) {
      _logger.e('Failed to check if initialized', error: e);
      return left(
        RemoteConfigFailure(
          message: 'Failed to check if initialized: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastFetchTime() async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getLastFetchTime();

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedLastFetchTime();
        return cachedResult.fold(
          (cacheFailure) => left(failure),
          (cachedTime) => right(cachedTime),
        );
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, DateTime?>> getLastActivatedTime() async {
    try {
      // Try to get from remote first
      final remoteResult = await remoteDatasource.getLastActivatedTime();

      return remoteResult.fold((failure) async {
        // Fallback to cached value
        final cachedResult = await localDatasource.getCachedLastActivatedTime();
        return cachedResult.fold(
          (cacheFailure) => left(failure),
          (cachedTime) => right(cachedTime),
        );
      }, (value) => right(value));
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

  @override
  Future<Either<Failure, bool>> isConfigStale() async {
    try {
      final result = await remoteDatasource.isConfigStale();
      return result;
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
