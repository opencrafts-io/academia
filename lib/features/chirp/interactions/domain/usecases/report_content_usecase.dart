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
    if (params.entityId == null || params.entityId!.isEmpty) {
      return Left(ServerFailure(message: 'Entity ID is required', error: 'Failed'));
    }

    switch (params.reportType) {
      case 'user':
        return await repository.reportUser(
          userId: params.entityId!,
          reason: params.reason,
        );
      case 'post':
        final postId = int.tryParse(params.entityId!);
        if (postId == null) {
          return Left(ServerFailure(message: 'Invalid post ID', error: 'Failed'));
        }
        return await repository.reportPost(
          postId: postId,
          reason: params.reason,
        );
      case 'comment':
        final commentId = int.tryParse(params.entityId!);
        if (commentId == null) {
          return Left(ServerFailure(message: 'Invalid comment ID', error: 'Failed'));
        }
        return await repository.reportComment(
          commentId: commentId,
          reason: params.reason,
        );
      case 'community':
        final communityId = int.tryParse(params.entityId!);
        if (communityId == null) {
          return Left(ServerFailure(message: 'Invalid community ID', error: 'Failed'));
        }
        return await repository.reportCommunity(
          communityId: communityId,
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
