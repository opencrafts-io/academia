import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class ChirpUserRepositoryImpl extends ChirpUserRepository {
  final ChirpUserLocalDataSource chirpUserLocalDataSource;
  final ChirpUserRemoteDataSource chirpRemoteDataSource;

  ChirpUserRepositoryImpl({
    required this.chirpRemoteDataSource,
    required this.chirpUserLocalDataSource,
  });

  @override
  Future<Either<Failure, ChirpUser>> getChirpUserByID(String userID) async {
    final localResult = await chirpUserLocalDataSource.getCachedChirpUserByID(
      userID,
    );

    if (localResult.isRight() && localResult.getOrElse(() => null) != null) {
      return right(localResult.getOrElse(() => null)!.toEntity());
    }

    final remoteResult = await chirpRemoteDataSource.getChirpUserByID(userID);

    return remoteResult.fold(
      (failure) => left(failure),
      (chirpUserData) async {
        final cacheResult = await chirpUserLocalDataSource
            .createorUpdateChirpUser(chirpUserData);
        return cacheResult.fold(
          (cacheFailure) =>
              left(cacheFailure),
          (cachedUser) =>
              right(cachedUser.toEntity()), 
        );
      },
    );
  }

  @override
  Future<Either<Failure, ChirpUser>> getChirpUserByUsername(
    String username,
  ) async {
    final localResult = await chirpUserLocalDataSource
        .getCachedChirpUserByUsername(username);

    if (localResult.isRight() && localResult.getOrElse(() => null) != null) {
      return right(localResult.getOrElse(() => null)!.toEntity());
    }

    final remoteResult = await chirpRemoteDataSource.getChirpUserByUsername(
      username,
    );

    return remoteResult.fold((failure) => left(failure), (chirpUserData) async {
      final cacheResult = await chirpUserLocalDataSource
          .createorUpdateChirpUser(chirpUserData);
      return cacheResult.fold(
        (cacheFailure) => left(cacheFailure),
        (cachedUser) => right(cachedUser.toEntity()),
      );
    });
  }
}
