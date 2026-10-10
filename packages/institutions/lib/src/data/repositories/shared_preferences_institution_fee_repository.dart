import 'dart:convert';

import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/institution_repositories.dart';

class SharedPreferencesInstitutionFeeRepository
    implements InstitutionFeeRepository {
  SharedPreferencesInstitutionFeeRepository(this.preferences);

  final SharedPreferences preferences;
  static const String _prefix = 'institutions_fee_v1_';
  static const String _indexPrefix = 'institutions_fee_index_v1_';

  String _scope(String accountId, int institutionId) =>
      '$accountId|$institutionId';

  String _indexKey(String accountId, int institutionId) =>
      '$_indexPrefix${sha256.convert(utf8.encode(_scope(accountId, institutionId)))}';

  String _statementKey(String accountId, int institutionId, String? term) =>
      '$_prefix${sha256.convert(utf8.encode('${_scope(accountId, institutionId)}|${term ?? ''}'))}';

  @override
  Future<Either<Failure, FeeStatementEntity?>> getFeeStatement({
    required String accountId,
    required int institutionId,
    String? term,
  }) async {
    try {
      final encoded = preferences.getString(
        _statementKey(accountId, institutionId, term),
      );
      if (encoded == null) return const Right(null);
      final decoded = jsonDecode(encoded);
      if (decoded is! Map) return const Right(null);
      return Right(
        FeeStatementEntity.fromJson(decoded.cast<String, Object?>()),
      );
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not read the stored fee statement.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<FeeStatementEntity>>> listFeeStatements({
    required String accountId,
    required int institutionId,
  }) async {
    try {
      final terms = _readIndex(accountId, institutionId);
      final statements = <FeeStatementEntity>[];
      for (final term in terms) {
        final encoded = preferences.getString(
          _statementKey(accountId, institutionId, term),
        );
        if (encoded == null) continue;
        final decoded = jsonDecode(encoded);
        if (decoded is Map) {
          statements.add(
            FeeStatementEntity.fromJson(decoded.cast<String, Object?>()),
          );
        }
      }
      return Right(statements);
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not list the stored fee statements.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FeeStatementEntity>> upsertFeeStatement(
    FeeStatementEntity statement,
  ) async {
    try {
      final key = _statementKey(
        statement.accountId,
        statement.institutionId,
        statement.term,
      );
      final existingEncoded = preferences.getString(key);
      FeeStatementEntity merged = statement;
      if (existingEncoded != null) {
        final decoded = jsonDecode(existingEncoded);
        if (decoded is Map) {
          final existing = FeeStatementEntity.fromJson(
            decoded.cast<String, Object?>(),
          );
          merged = existing.mergedWith(statement);
        }
      }
      await preferences.setString(key, jsonEncode(merged.toJson()));
      await _addToIndex(
        statement.accountId,
        statement.institutionId,
        statement.term,
      );
      return Right(merged);
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not save the fee statement.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAccount(String accountId) async {
    try {
      for (final key in preferences.getKeys().where(
        (key) => key.startsWith(_prefix) || key.startsWith(_indexPrefix),
      )) {
        final encoded = preferences.getString(key);
        if (encoded == null) continue;
        if (key.startsWith(_prefix)) {
          try {
            final decoded = jsonDecode(encoded);
            if (decoded is Map && decoded['accountId'] == accountId) {
              await preferences.remove(key);
            }
          } on FormatException {
            // Corrupt entries are left for the next read to discover.
          }
        }
      }
      return const Right(unit);
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not clear the stored fee statements.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  List<String?> _readIndex(String accountId, int institutionId) {
    final encoded = preferences.getString(_indexKey(accountId, institutionId));
    if (encoded == null) return const [];
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! List) return const [];
      return decoded.map((value) => value as String?).toList();
    } on FormatException {
      return const [];
    }
  }

  Future<void> _addToIndex(
    String accountId,
    int institutionId,
    String? term,
  ) async {
    final terms = _readIndex(accountId, institutionId);
    if (!terms.contains(term)) {
      await preferences.setString(
        _indexKey(accountId, institutionId),
        jsonEncode([...terms, term]),
      );
    }
  }
}
