import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/chirp_user_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/chirp_user.dart';
import '../../domain/repositories/chirp_user_repository.dart';
import '../datasources/chirp_user_remote_datasource.dart';
import '../datasources/chirp_user_local_datasource.dart';

class ChirpUserRepositoryImpl implements ChirpUserRepository {
  final ChirpUserRemoteDatasource remoteDataSource;
  final ChirpUserLocalDataSource localDataSource;

  ChirpUserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ChirpUser>>> getChirpUsers() async {
    try {
      final usersResult = await remoteDataSource.getChirpUsers();

      return await usersResult.fold(
        (failure) async {
          // TODO: Uncomment when cache is ready
          // // Remote failed, try cache
          // try {
          //   final cachedUsers = await localDataSource.getCachedChirpUsers();
          //   return Right(
          //     cachedUsers.map((data) => data.toEntity()).toList(),
          //   );
          // } catch (cacheError) {
          //   return Left(failure); // Return original failure if cache also fails
          // }
          return Left(failure);
        },
        (users) async {
          // TODO: Uncomment when cache is ready
          // // Remote succeeded, cache the data
          // try {
          //   await localDataSource.cacheChirpUsers(users);
          // } catch (cacheError) {
          //   // Log cache error but continue
          //   print('Cache error: $cacheError');
          // }
          return Right(users.map((data) => data.toEntity()).toList());
        },
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
      final userResult = await remoteDataSource.getChirpUserById(userId);

      return userResult.fold(
        (failure) => Left(failure),
        (user) => Right(user.toEntity()),
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
      final userResult = await remoteDataSource.createChirpUser(user.toData());

      return userResult.fold(
        (failure) => Left(failure),
        (createdUser) => Right(createdUser.toEntity()),
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
      final userResult = await remoteDataSource.updateChirpUser(user.toData());

      return userResult.fold(
        (failure) => Left(failure),
        (updatedUser) => Right(updatedUser.toEntity()),
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
    String query,
  ) async {
    try {
      final usersResult = await remoteDataSource.searchChirpUsers(query);

      return usersResult.fold(
        (failure) => Left(failure),
        (users) => Right(users.map((data) => data.toEntity()).toList()),
      );
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
