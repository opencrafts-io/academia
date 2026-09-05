import 'dart:async';

import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: domain.PlanRepository)
class PlanRepositoryImpl implements domain.PlanRepository {
  PlanRepositoryImpl({
    required this._planLocalDatasource,
    required this._planRemoteDataSource,
  });

  final PlanRemoteDataSource _planRemoteDataSource;
  final PlanLocalDatasource _planLocalDatasource;

  @override
  Future<Either<Failure, domain.Plan>> getPlanByCode(String planCode) async {
    final remoteResult = await _planRemoteDataSource.getPlan(planCode);

    return remoteResult.fold<Future<Either<Failure, domain.Plan>>>(
      (failure) async {
        final localResult = await _planLocalDatasource.getPlanByCode(planCode);
        return localResult.fold(
          (localFailure) => left(localFailure),
          (plan) => right(plan.toDomain()),
        );
      },
      (planDto) async {
        // Cache is best-effort: a write failure here must not turn a
        // successful remote fetch into a failed call.
        unawaited(_cachePlan(planDto));
        return right(planDto.toDomain());
      },
    );
  }

  @override
  Future<Either<Failure, List<domain.Plan>>> getPlans() async {
    final remoteResult = await _planRemoteDataSource.getPlans();

    return remoteResult.fold<Future<Either<Failure, List<domain.Plan>>>>(
      (failure) async {
        final localResult = await _planLocalDatasource.getAllPlans();
        return localResult.fold(
          (localFailure) => left(localFailure),
          (plans) => right(plans.map((plan) => plan.toDomain()).toList()),
        );
      },
      (planDtos) async {
        unawaited(_cachePlans(planDtos));
        return right(planDtos.map((dto) => dto.toDomain()).toList());
      },
    );
  }

  /// Writes a freshly fetched [planDto] to the local cache: updates the
  /// existing row if one with the same code exists, otherwise inserts a
  /// new one. Failures are logged rather than surfaced, since caching is
  /// a side effect of an already-successful remote call.
  Future<void> _cachePlan(PlanDto planDto) async {
    final existingResult = await _planLocalDatasource.getPlanByCode(
      planDto.code,
    );

    final writeResult = await existingResult.fold(
      (_) => _planLocalDatasource.createPlan(planDto.toCompanion()),
      (existingPlan) => _planLocalDatasource.updatePlan(
        planDto.toCompanion(id: existingPlan.id),
      ),
    );

    writeResult.fold((failure) {
      if (kDebugMode) {
        debugPrint('Failed to cache plan "${planDto.code}": $failure');
      }
    }, (_) {});
  }

  /// Caches each plan sequentially. Sequential (rather than
  /// [Future.wait]) to avoid piling up concurrent writes against the
  /// local database; batch this into a single transaction on the DAO
  /// side if that ever becomes a bottleneck.
  Future<void> _cachePlans(List<PlanDto> planDtos) async {
    for (final planDto in planDtos) {
      await _cachePlan(planDto);
    }
  }
}
