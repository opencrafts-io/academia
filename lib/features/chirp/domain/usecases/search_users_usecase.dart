import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/entities/chirp_user.dart';
import '../../domain/repositories/chirp_user_repository.dart';

class SearchUsersUseCase implements UseCase<List<ChirpUser>, String> {
  final ChirpUserRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChirpUser>>> call(String query) async {
    return await repository.searchChirpUsers(query);
  }
}
