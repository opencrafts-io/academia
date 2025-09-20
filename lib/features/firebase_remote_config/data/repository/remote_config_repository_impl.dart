import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigRemoteDatasource remoteDatasource;
  final Logger _logger = Logger();

  RemoteConfigRepositoryImpl({required this.remoteDatasource});

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

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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

      return remoteResult.fold(
        (failure) => left(failure),
        (value) => right(value),
      );
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
}
