import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_search_repository.dart';
import '../datasources/user_search_remote_datasource.dart';

class UserSearchRepositoryImpl implements UserSearchRepository {
  final UserSearchRemoteDatasource remoteDataSource;

  UserSearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<UserProfile>>> searchUsers(String query) async {
    try {
      return await remoteDataSource.searchUsers(query);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred while searching users',
          error: e,
        ),
      );
    }
  }
}
