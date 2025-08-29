import 'package:academia/core/core.dart';
import 'package:academia/features/firebase_remote_config/firebase_remote_config.dart';
import 'package:dartz/dartz.dart';

class InitializeRemoteConfigUsecase implements UseCase<void, NoParams> {
  final RemoteConfigRepository repository;

  InitializeRemoteConfigUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.initialize();
  }
}

