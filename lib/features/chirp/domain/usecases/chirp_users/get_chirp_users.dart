import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/chirp_user.dart';
import '../../repositories/chirp_user_repository.dart';

class GetChirpUsers implements UseCase<List<ChirpUser>, NoParams> {
  final ChirpUserRepository repository;

  GetChirpUsers(this.repository);

  @override
  Future<Either<Failure, List<ChirpUser>>> call(NoParams params) async {
    return await repository.getChirpUsers();
  }
}
