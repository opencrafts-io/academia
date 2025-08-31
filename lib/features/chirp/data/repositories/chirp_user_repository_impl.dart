import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/entities/chirp_user.dart';
import '../../domain/repositories/chirp_user_repository.dart';
import '../datasources/chirp_user_remote_datasource.dart';
import '../datasources/conversations/messaging_local_datasource.dart';
import '../models/chirp_user_model.dart';

class ChirpUserRepositoryImpl implements ChirpUserRepository {
  final ChirpUserRemoteDatasource remoteDataSource;
  final MessagingLocalDataSource localDataSource;

  ChirpUserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ChirpUser>>> getChirpUsers() async {
    try {
      final result = await remoteDataSource.getChirpUsers();
      return result.fold(
        (failure) => Left(failure),
        (users) => Right(users.map((userData) => userData.toEntity()).toList()),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while fetching chirp users',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUser>> getChirpUserById(String userId) async {
    try {
      final result = await remoteDataSource.getChirpUserById(userId);
      return result.fold(
        (failure) => Left(failure),
        (userData) => Right(userData.toEntity()),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while fetching chirp user',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUser>> createChirpUser(ChirpUser user) async {
    try {
      final userData = user.toData();
      final result = await remoteDataSource.createChirpUser(userData);
      return result.fold(
        (failure) => Left(failure),
        (userData) => Right(userData.toEntity()),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while creating chirp user',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUser>> updateChirpUser(ChirpUser user) async {
    try {
      final userData = user.toData();
      final result = await remoteDataSource.updateChirpUser(userData);
      return result.fold(
        (failure) => Left(failure),
        (userData) => Right(userData.toEntity()),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while updating chirp user',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteChirpUser(String userId) async {
    try {
      final result = await remoteDataSource.deleteChirpUser(userId);
      return result.fold((failure) => Left(failure), (_) => const Right(null));
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while deleting chirp user',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChirpUser>>> searchChirpUsers(
    String query, {
    String type = 'combined',
    int limit = 10,
  }) async {
    try {
      final result = await remoteDataSource.searchChirpUsers(
        query,
        type: type,
        limit: limit,
      );
      return await result.fold((failure) async => Left(failure), (users) async {
        // Cache all found users for future use
        for (final userData in users) {
          await localDataSource.cacheUser(userData);
        }
        return Right(users.map((userData) => userData.toEntity()).toList());
      });
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while searching chirp users',
          error: e,
        ),
      );
    }
  }
}
