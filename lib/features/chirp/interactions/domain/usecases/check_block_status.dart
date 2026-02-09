import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/block_status.dart';

class CheckBlockStatus implements UseCase<BlockStatus, CheckBlockStatusParams> {
  final InteractionsRepository repository;

  CheckBlockStatus(this.repository);

  @override
  Future<Either<Failure, BlockStatus>> call(
    CheckBlockStatusParams params,
  ) async {
    return await repository.checkBlockStatus(
      entityType: params.entityType,
      entityId: params.entityId,
    );
  }
}

class CheckBlockStatusParams extends Equatable {
  final String entityType;
  final String entityId;

  const CheckBlockStatusParams({
    required this.entityType,
    required this.entityId,
  });

  @override
  List<Object?> get props => [entityType, entityId];
}
