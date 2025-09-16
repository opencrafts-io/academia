import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class SetSettingsUsecase implements UseCase<void, SetSettingsParams> {
  final RemoteConfigRepository repository;

  SetSettingsUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetSettingsParams params) async {
    return await repository.setSettings(params.settings);
  }
}

class SetSettingsParams {
  final RemoteConfigSettingsEntity settings;

  SetSettingsParams({required this.settings});
}

