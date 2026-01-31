import 'package:academia/features/chirp/interactions/domain/repository/interactions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import '../entities/report.dart';

class GetReports implements UseCase<List<Report>, GetReportsParams> {
  final InteractionsRepository repository;

  GetReports(this.repository);

  @override
  Future<Either<Failure, List<Report>>> call(GetReportsParams params) async {
    return await repository.getReports(
      type: params.type,
      status: params.status,
    );
  }
}

class GetReportsParams extends Equatable {
  final String? type;
  final String? status;

  const GetReportsParams({this.type, this.status});

  @override
  List<Object?> get props => [type, status];
}
