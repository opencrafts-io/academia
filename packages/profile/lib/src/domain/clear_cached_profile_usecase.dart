import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'profile_repository.dart';

@injectable
class ClearCachedProfileUsecase implements UseCase<void, NoUseCaseParams> {
  const ClearCachedProfileUsecase({required this.repository});

  final ProfileRepository repository;

  @override
  Future<Either<Failure, void>> call(NoUseCaseParams params) =>
      repository.clearCachedUserProfile();
}
