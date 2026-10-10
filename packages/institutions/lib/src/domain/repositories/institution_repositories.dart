import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

/// Owns the academic student profile for one Academia account/institution
/// membership. Implementations must merge rather than overwrite on repeat
/// import -- see [AcademicProfileEntity.mergedWith] -- so a partial capture
/// never deletes a previously observed field.
abstract interface class InstitutionProfileRepository {
  Future<Either<Failure, AcademicProfileEntity?>> getProfile({
    required String accountId,
    required int institutionId,
  });

  /// Merges [profile] into any existing stored profile for the same
  /// account/institution and persists the result. Never creates a second
  /// profile record for the same account/institution pair.
  Future<Either<Failure, AcademicProfileEntity>> upsertProfile(
    AcademicProfileEntity profile,
  );

  /// Removes all profile data for [accountId], used on disconnect per the
  /// retention policy. Never called implicitly from a partial capture.
  Future<Either<Failure, Unit>> clearAccount(String accountId);
}

/// Owns fee statements for one Academia account/institution membership,
/// optionally scoped by term. Implementations must merge line items by
/// their stable source identity rather than replacing a statement wholesale,
/// so absence from a partial capture is never treated as deletion.
abstract interface class InstitutionFeeRepository {
  Future<Either<Failure, List<FeeStatementEntity>>> listFeeStatements({
    required String accountId,
    required int institutionId,
  });

  Future<Either<Failure, FeeStatementEntity?>> getFeeStatement({
    required String accountId,
    required int institutionId,
    String? term,
  });

  /// Merges [statement] into any existing stored statement for the same
  /// account/institution/term and persists the result. Never creates a
  /// duplicate statement for the same account/institution/term triple.
  Future<Either<Failure, FeeStatementEntity>> upsertFeeStatement(
    FeeStatementEntity statement,
  );

  Future<Either<Failure, Unit>> clearAccount(String accountId);
}
