import 'package:core/core.dart';

import 'profile_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestAccountDeletionUsecase
    implements UseCase<String, NoUseCaseParams> {
  final ProfileRepository profileRepository;

  RequestAccountDeletionUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, String>> call(NoUseCaseParams params) async {
    return await profileRepository.requestAccountDeletion();
  }
}
