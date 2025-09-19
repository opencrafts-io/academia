import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class InitializeAdMobUsecase implements UseCase<void, NoParams> {
  final AdRepository repository;

  InitializeAdMobUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.initializeAdMob();
  }
}
