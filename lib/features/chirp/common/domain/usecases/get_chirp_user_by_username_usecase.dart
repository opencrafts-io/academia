import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/common/common.dart';
import 'package:dartz/dartz.dart';

class GetChirpUserByUsernameUsecase extends UseCase<ChirpUser, String> {
  final ChirpUserRepository chirpUserRepository;

  GetChirpUserByUsernameUsecase({required this.chirpUserRepository});

  @override
  Future<Either<Failure, ChirpUser>> call(String username) async {
    return await chirpUserRepository.getChirpUserByUsername(username);
  }
}
