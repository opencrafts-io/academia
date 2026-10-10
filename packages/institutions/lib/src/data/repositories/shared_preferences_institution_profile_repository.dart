import 'dart:convert';

import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/institution_repositories.dart';

/// Local-only profile storage. This is intentionally independent of the
/// shared offline-sync database used by `packages/courses`; migrating
/// profile/fee persistence into that database is tracked as later work in
/// `docs/portal-sync-plan.md`'s package boundary table.
class SharedPreferencesInstitutionProfileRepository
    implements InstitutionProfileRepository {
  SharedPreferencesInstitutionProfileRepository(this.preferences);

  final SharedPreferences preferences;
  static const String _prefix = 'institutions_profile_v1_';

  String _key(String accountId, int institutionId) =>
      '$_prefix${sha256.convert(utf8.encode('$accountId|$institutionId'))}';

  @override
  Future<Either<Failure, AcademicProfileEntity?>> getProfile({
    required String accountId,
    required int institutionId,
  }) async {
    try {
      final encoded = preferences.getString(_key(accountId, institutionId));
      if (encoded == null) return const Right(null);
      final decoded = jsonDecode(encoded);
      if (decoded is! Map) return const Right(null);
      return Right(
        AcademicProfileEntity.fromJson(decoded.cast<String, Object?>()),
      );
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not read the stored academic profile.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AcademicProfileEntity>> upsertProfile(
    AcademicProfileEntity profile,
  ) async {
    try {
      final key = _key(profile.accountId, profile.institutionId);
      final existingEncoded = preferences.getString(key);
      AcademicProfileEntity merged = profile;
      if (existingEncoded != null) {
        final decoded = jsonDecode(existingEncoded);
        if (decoded is Map) {
          final existing = AcademicProfileEntity.fromJson(
            decoded.cast<String, Object?>(),
          );
          merged = existing.mergedWith(profile);
        }
      }
      await preferences.setString(key, jsonEncode(merged.toJson()));
      return Right(merged);
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not save the academic profile.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAccount(String accountId) async {
    try {
      // Stored keys are hashed together with the institution id, so every
      // profile key is scanned and decoded to match it against the account.
      for (final key in preferences.getKeys().where(
        (key) => key.startsWith(_prefix),
      )) {
        final encoded = preferences.getString(key);
        if (encoded == null) continue;
        try {
          final decoded = jsonDecode(encoded);
          if (decoded is Map && decoded['accountId'] == accountId) {
            await preferences.remove(key);
          }
        } on FormatException {
          // Corrupt entries are left for the next read to discover and skip.
        }
      }
      return const Right(unit);
    } catch (error, stack) {
      return Left(
        Failure.cache(
          message: 'Could not clear the stored academic profile.',
          error: error,
          stackTrace: stack,
        ),
      );
    }
  }
}
