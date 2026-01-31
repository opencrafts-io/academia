import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/block.dart';

class BlockUser implements UseCase<Block, String> {
  final InteractionsRepository repository;

  BlockUser(this.repository);

  @override
  Future<Either<Failure, Block>> call(String userId) async {
    return await repository.blockUser(userId);
  }
}
