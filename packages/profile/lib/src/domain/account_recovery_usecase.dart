import 'package:core/core.dart';

import 'profile_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestAccountRecoveryUsecase
    implements UseCase<String, NoUseCaseParams> {
  final ProfileRepository profileRepository;

  RequestAccountRecoveryUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, String>> call(NoUseCaseParams params) async {
    return await profileRepository.requestAccountRecovery();
  }
}
