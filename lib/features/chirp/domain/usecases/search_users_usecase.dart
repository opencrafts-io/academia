import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/entities/chirp_user.dart';
import '../../domain/repositories/chirp_user_repository.dart';

class SearchUsersParams {
  final String query;
  final String type;
  final int limit;

  const SearchUsersParams({
    required this.query,
    this.type = 'combined',
    this.limit = 10,
  });
}

class SearchUsersUseCase
    implements UseCase<List<ChirpUser>, SearchUsersParams> {
  final ChirpUserRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChirpUser>>> call(
    SearchUsersParams params,
  ) async {
    return await repository.searchChirpUsers(
      params.query,
      type: params.type,
      limit: params.limit,
    );
  }
}
