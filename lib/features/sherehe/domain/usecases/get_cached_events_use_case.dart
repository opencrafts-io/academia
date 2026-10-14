import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:profile/profile.dart';

class GetCachedUserProfileUseCase {
  final ProfileRepository repository;

  GetCachedUserProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call() =>
      repository.getCachedUserProfile();

  List<Object> get props => [repository];
}
