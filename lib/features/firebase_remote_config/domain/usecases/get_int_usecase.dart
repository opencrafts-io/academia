import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetIntUsecase implements UseCase<int, GetIntParams> {
  final RemoteConfigRepository repository;

  GetIntUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(GetIntParams params) async {
    return await repository.getInt(
      params.key,
      defaultValue: params.defaultValue,
    );
  }
}

class GetIntParams {
  final String key;
  final int defaultValue;

  GetIntParams({
    required this.key,
    this.defaultValue = 0,
  });
}

