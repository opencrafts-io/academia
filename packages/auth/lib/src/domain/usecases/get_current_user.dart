import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPreviousAuthState implements UseCase<List<Token>, NoUseCaseParams> {
  final AuthRepository repository;

  GetPreviousAuthState(this.repository);

  @override
  Future<Either<Failure, List<Token>>> call(NoUseCaseParams params) async {
    return await repository.getPreviousAuthState();
  }
}
