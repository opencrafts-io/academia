import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/common/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// ChirpUserRepository
/// An abstact class representing the various actions
/// that can be performed on chirp users
abstract class ChirpUserRepository {
  /// Retrieves a chirp user by their user_id specified by [userID]
  Future<Either<Failure, ChirpUser>> getChirpUserByID(String userID);

  /// Retrieves a chirp user by their username specified by [usernme]
  Future<Either<Failure, ChirpUser>> getChirpUserByUsername(String usernme);
}
