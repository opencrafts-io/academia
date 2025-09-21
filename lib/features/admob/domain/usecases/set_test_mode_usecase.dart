import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class SetTestModeParams {
  final bool enabled;

  SetTestModeParams({required this.enabled});
}

class SetTestModeUsecase implements UseCase<void, SetTestModeParams> {
  final AdRepository repository;

  SetTestModeUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetTestModeParams params) async {
    return await repository.setTestMode(params.enabled);
  }
}
