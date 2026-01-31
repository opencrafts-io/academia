import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/report.dart';

class ReportContent implements UseCase<Report, ReportContentParams> {
  final InteractionsRepository repository;

  ReportContent(this.repository);

  @override
  Future<Either<Failure, Report>> call(ReportContentParams params) async {
    switch (params.reportType) {
      case 'user':
        return await repository.reportUser(
          userId: params.entityId!,
          reason: params.reason,
        );
      case 'post':
        return await repository.reportPost(
          postId: int.parse(params.entityId!),
          reason: params.reason,
        );
      case 'comment':
        return await repository.reportComment(
          commentId: int.parse(params.entityId!),
          reason: params.reason,
        );
      case 'community':
        return await repository.reportCommunity(
          communityId: int.parse(params.entityId!),
          reason: params.reason,
        );
      default:
        return Left(ServerFailure(message: 'Invalid report type', error: 'Failed'));
    }
  }
}

class ReportContentParams extends Equatable {
  final String reportType;
  final String? entityId;
  final String reason;

  const ReportContentParams({
    required this.reportType,
    this.entityId,
    required this.reason,
  });

  @override
  List<Object?> get props => [reportType, entityId, reason];
}
