import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/domain/entities/chirp_user.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_user_repository.dart';
import 'package:dartz/dartz.dart';

class SearchVerisafeUsersUseCase {
  final ChirpUserRepository chirpUserRepository;

  SearchVerisafeUsersUseCase({required this.chirpUserRepository});

  Future<Either<Failure, List<ChirpUser>>> searchChirpUsers(
    String query, {
    String type = 'combined',
    int limit = 10,
  })  {
    return chirpUserRepository.searchChirpUsers(query);
  }
}