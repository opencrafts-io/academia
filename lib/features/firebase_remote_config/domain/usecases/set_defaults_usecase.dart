import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class SetDefaultsUsecase implements UseCase<void, SetDefaultsParams> {
  final RemoteConfigRepository repository;

  SetDefaultsUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetDefaultsParams params) async {
    return await repository.setDefaults(params.defaults);
  }
}

class SetDefaultsParams {
  final Map<String, dynamic> defaults;

  SetDefaultsParams({required this.defaults});
}

