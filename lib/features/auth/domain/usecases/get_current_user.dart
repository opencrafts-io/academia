import 'package:academia/features/auth/auth.dart';

import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';

class GetPreviousAuthState implements UseCase<List<Token>, NoParams> {
  final AuthRepository repository;

  GetPreviousAuthState(this.repository);

  @override
  Future<Either<Failure, List<Token>>> call(NoParams params) async {
    return await repository.getPreviousAuthState();
  }
}
