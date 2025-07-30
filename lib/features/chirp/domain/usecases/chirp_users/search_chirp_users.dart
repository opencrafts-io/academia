import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/chirp_user.dart';
import '../../repositories/chirp_user_repository.dart';

class SearchChirpUsers implements UseCase<List<ChirpUser>, String> {
  final ChirpUserRepository repository;

  SearchChirpUsers(this.repository);

  @override
  Future<Either<Failure, List<ChirpUser>>> call(String query) async {
    return await repository.searchChirpUsers(query);
  }
}
