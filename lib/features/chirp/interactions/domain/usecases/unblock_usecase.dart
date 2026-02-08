import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';

class UnblockById implements UseCase<void, int> {
  final InteractionsRepository repository;

  UnblockById(this.repository);

  @override
  Future<Either<Failure, void>> call(int blockId) async {
    return await repository.unblockById(blockId);
  }
}
