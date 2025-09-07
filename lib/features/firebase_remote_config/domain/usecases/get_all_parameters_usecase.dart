import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class GetAllParametersUsecase implements UseCase<Map<String, dynamic>, NoParams> {
  final RemoteConfigRepository repository;

  GetAllParametersUsecase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    return await repository.getAllParameters();
  }
}

