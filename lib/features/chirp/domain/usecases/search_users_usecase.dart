import 'package:academia/core/core.dart';
import '../entities/chirp_user.dart';
import 'package:dartz/dartz.dart';
import '../repositories/chirp_user_repository.dart';

class SearchUsersUseCase implements UseCase<List<ChirpUser>, String> {
  final ChirpUserRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChirpUser>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }

    return await repository.searchChirpUsers(query.trim());
  }
}
