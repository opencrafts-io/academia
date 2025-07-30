import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';

abstract class ChirpUserRemoteDatasource {
  Future<Either<Failure, List<ChirpUserData>>> getChirpUsers();
  Future<Either<Failure, ChirpUserData>> getChirpUserById(String userId);
  Future<Either<Failure, ChirpUserData>> createChirpUser(ChirpUserData user);
  Future<Either<Failure, ChirpUserData>> updateChirpUser(ChirpUserData user);
  Future<Either<Failure, void>> deleteChirpUser(String userId);
  Future<Either<Failure, List<ChirpUserData>>> searchChirpUsers(String query);
}

class ChirpUserRemoteDatasourceImpl
    with DioErrorHandler
    implements ChirpUserRemoteDatasource {
  final DioClient dioClient;

  ChirpUserRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ChirpUserData>>> getChirpUsers() async {
    // TODO: Uncomment when API is ready
    // try {
    //   final response = await dioClient.dio.get('/chirp/users/');
    //
    //   if (response.statusCode != 200) {
    //     return Left(
    //       ServerFailure(
    //         message: 'Failed to fetch chirp users',
    //         error: 'Status code: ${response.statusCode}',
    //       ),
    //     );
    //   }
    //
    //   final users = (response.data as List)
    //       .map((json) => ChirpUserData.fromJson(json))
    //       .toList();
    //
    //   return Right(users);
    // } on DioException catch (dioError) {
    //   return Left(handleDioError(dioError));
    // } catch (e) {
    //   return Left(
    //     ServerFailure(
    //       message: 'An unexpected error occurred. Please try again.',
    //       error: e,
    //     ),
    //   );
    // }

    // DUMMY DATA
    return _getDummyChirpUsers();
  }

  @override
  Future<Either<Failure, ChirpUserData>> getChirpUserById(String userId) async {
    // TODO: Implement when API is ready
    final usersResult = await getChirpUsers();
    return usersResult.fold((failure) => Left(failure), (users) {
      try {
        final user = users.firstWhere((user) => user.id == userId);
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(message: 'User not found', error: e));
      }
    });
  }

  @override
  Future<Either<Failure, ChirpUserData>> createChirpUser(
    ChirpUserData user,
  ) async {
    // TODO: Implement when API is ready
    return Right(user);
  }

  @override
  Future<Either<Failure, ChirpUserData>> updateChirpUser(
    ChirpUserData user,
  ) async {
    // TODO: Implement when API is ready
    return Right(user);
  }

  @override
  Future<Either<Failure, void>> deleteChirpUser(String userId) async {
    // TODO: Implement when API is ready
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<ChirpUserData>>> searchChirpUsers(
    String query,
  ) async {
    // TODO: Implement when API is ready
    final usersResult = await getChirpUsers();
    return usersResult.fold((failure) => Left(failure), (users) {
      final filteredUsers = users
          .where(
            (user) =>
                user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      return Right(filteredUsers);
    });
  }

  // TODO: Remove
  Either<Failure, List<ChirpUserData>> _getDummyChirpUsers() {
    final dummyUsers = [
      ChirpUserData(
        id: 'user_1',
        name: 'Scarlett Johansson',
        email: 'scarlett@example.com',
        vibepoints: 150,
        avatarUrl: null,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      ChirpUserData(
        id: 'user_2',
        name: 'John Doe',
        email: 'john@example.com',
        vibepoints: 75,
        avatarUrl: null,
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      ChirpUserData(
        id: 'user_3',
        name: 'Jane Smith',
        email: 'jane@example.com',
        vibepoints: 200,
        avatarUrl: null,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
    ];

    return Right(dummyUsers);
  }
}
