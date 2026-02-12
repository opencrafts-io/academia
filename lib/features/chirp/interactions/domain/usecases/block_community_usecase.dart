import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/block.dart';

class BlockCommunity implements UseCase<Block, int> {
  final InteractionsRepository repository;

  BlockCommunity(this.repository);

  @override
  Future<Either<Failure, Block>> call(int communityId) async {
    return await repository.blockCommunity(communityId);
  }
}
