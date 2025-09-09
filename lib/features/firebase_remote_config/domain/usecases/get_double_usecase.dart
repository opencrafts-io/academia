import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetDoubleUsecase implements UseCase<double, GetDoubleParams> {
  final RemoteConfigRepository repository;

  GetDoubleUsecase(this.repository);

  @override
  Future<Either<Failure, double>> call(GetDoubleParams params) async {
    return await repository.getDouble(
      params.key,
      defaultValue: params.defaultValue,
    );
  }
}

class GetDoubleParams {
  final String key;
  final double defaultValue;

  GetDoubleParams({
    required this.key,
    this.defaultValue = 0.0,
  });
}

