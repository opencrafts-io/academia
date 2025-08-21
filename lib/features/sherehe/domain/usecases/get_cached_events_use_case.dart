import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCachedUserProfileUseCase {
  final ProfileRepository repository;

  GetCachedUserProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    return await repository.getCachedUserProfile();
  }

  List<Object> get props => [repository];
}