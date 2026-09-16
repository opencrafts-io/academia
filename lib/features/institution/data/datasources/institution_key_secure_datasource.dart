import 'dart:convert';

import 'package:academia/core/core.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists and retrieves [InstitutionKey]s (portal login credentials used
/// to authenticate a Magnet scrape) using [FlutterSecureStorage], one entry
/// per institution, latest save wins.
class InstitutionKeySecureDatasource {
  static const _keyPrefix = 'institution_key_';

  final FlutterSecureStorage _storage;

  InstitutionKeySecureDatasource({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock_this_device,
            ),
          );

  String _keyFor(int institutionId) => '$_keyPrefix$institutionId';

  /// Returns the key set stored for [institutionId], or `null` if none has
  /// been saved (or migrated from the legacy local cache) yet.
  Future<Either<Failure, InstitutionKey?>> getInstitutionKey(
    int institutionId,
  ) async {
    try {
      final raw = await _storage.read(key: _keyFor(institutionId));
      if (raw == null) return right(null);

      final json = jsonDecode(raw) as Map<String, dynamic>;
      return right(
        InstitutionKey(
          institutionId: json['institution_id'] as int,
          commandId: json['command_id'] as String,
          keySets: Map<String, dynamic>.from(json['key_sets'] as Map),
          createdAt: DateTime.parse(json['created_at'] as String),
        ),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to read the stored institution key",
        ),
      );
    }
  }

  /// Persists [key], overwriting whatever was previously stored for the
  /// same institution.
  Future<Either<Failure, void>> saveInstitutionKey(InstitutionKey key) async {
    try {
      final json = {
        'institution_id': key.institutionId,
        'command_id': key.commandId,
        'key_sets': key.keySets,
        'created_at': key.createdAt.toIso8601String(),
      };
      await _storage.write(
        key: _keyFor(key.institutionId),
        value: jsonEncode(json),
      );
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to save the institution key securely",
        ),
      );
    }
  }
}
