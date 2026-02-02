import 'package:academia/core/core.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:dartz/dartz.dart';

class RequestAccountRecoveryUsecase implements UseCase<String, NoParams> {
  final ProfileRepository profileRepository;

  RequestAccountRecoveryUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await profileRepository.requestAccountRecovery();
  }
}
