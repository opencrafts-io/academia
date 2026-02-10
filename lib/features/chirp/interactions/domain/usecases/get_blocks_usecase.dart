import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/block.dart';

class GetBlocks implements UseCase<List<Block>, String?> {
  final InteractionsRepository repository;

  GetBlocks(this.repository);

  @override
  Future<Either<Failure, List<Block>>> call(String? type) async {
    return await repository.getBlocks(type: type);
  }
}
