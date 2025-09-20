import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteConfigRepository {
  /// Initialize Firebase Remote Config
  Future<Either<Failure, void>> initialize();

  /// Fetch and activate remote config values
  Future<Either<Failure, void>> fetchAndActivate();

  /// Get a string value from remote config
  Future<Either<Failure, String>> getString(
    String key, {
    String defaultValue = '',
  });

  /// Get a boolean value from remote config
  Future<Either<Failure, bool>> getBool(
    String key, {
    bool defaultValue = false,
  });

  /// Get an integer value from remote config
  Future<Either<Failure, int>> getInt(String key, {int defaultValue = 0});

  /// Get a double value from remote config
  Future<Either<Failure, double>> getDouble(
    String key, {
    double defaultValue = 0.0,
  });

  /// Get a JSON value from remote config
  Future<Either<Failure, Map<String, dynamic>>> getJson(
    String key, {
    Map<String, dynamic>? defaultValue,
  });

  /// Get all remote config parameters
  Future<Either<Failure, Map<String, dynamic>>> getAllParameters();
}
