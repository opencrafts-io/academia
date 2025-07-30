import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/chirp_user.dart';
import '../../repositories/chirp_user_repository.dart';

class GetChirpUserById implements UseCase<ChirpUser, String> {
  final ChirpUserRepository repository;

  GetChirpUserById(this.repository);

  @override
  Future<Either<Failure, ChirpUser>> call(String userId) async {
    return await repository.getChirpUserById(userId);
  }
}
