import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/chirp_user.dart';

abstract class ChirpUserRepository {
  Future<Either<Failure, List<ChirpUser>>> getChirpUsers();
  Future<Either<Failure, ChirpUser>> getChirpUserById(String userId);
  Future<Either<Failure, ChirpUser>> createChirpUser(ChirpUser user);
  Future<Either<Failure, ChirpUser>> updateChirpUser(ChirpUser user);
  Future<Either<Failure, void>> deleteChirpUser(String userId);
  Future<Either<Failure, List<ChirpUser>>> searchChirpUsers(String query);
}
