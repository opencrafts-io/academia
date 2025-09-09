import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetStringUsecase implements UseCase<String, GetStringParams> {
  final RemoteConfigRepository repository;

  GetStringUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(GetStringParams params) async {
    return await repository.getString(
      params.key,
      defaultValue: params.defaultValue,
    );
  }
}

class GetStringParams {
  final String key;
  final String defaultValue;

  GetStringParams({
    required this.key,
    this.defaultValue = '',
  });
}

