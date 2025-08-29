import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetJsonUsecase implements UseCase<Map<String, dynamic>, GetJsonParams> {
  final RemoteConfigRepository repository;

  GetJsonUsecase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(GetJsonParams params) async {
    return await repository.getJson(
      params.key,
      defaultValue: params.defaultValue,
    );
  }
}

class GetJsonParams {
  final String key;
  final Map<String, dynamic>? defaultValue;

  GetJsonParams({
    required this.key,
    this.defaultValue,
  });
}

