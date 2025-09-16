import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetSettingsUsecase implements UseCase<RemoteConfigSettingsEntity, NoParams> {
  final RemoteConfigRepository repository;

  GetSettingsUsecase(this.repository);

  @override
  Future<Either<Failure, RemoteConfigSettingsEntity>> call(NoParams params) async {
    return await repository.getSettings();
  }
}

