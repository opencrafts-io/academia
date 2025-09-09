import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetBoolUsecase implements UseCase<bool, GetBoolParams> {
  final RemoteConfigRepository repository;

  GetBoolUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(GetBoolParams params) async {
    return await repository.getBool(
      params.key,
      defaultValue: params.defaultValue,
    );
  }
}

class GetBoolParams {
  final String key;
  final bool defaultValue;

  GetBoolParams({
    required this.key,
    this.defaultValue = false,
  });
}

