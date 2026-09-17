import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_state.freezed.dart';

@freezed
abstract class PlanState with _$PlanState {
  const factory PlanState.initial() = _Initial;

  const factory PlanState.loading() = _Loading;

  const factory PlanState.plansLoaded(List<Plan> plans) = _PlansLoaded;

  const factory PlanState.planLoaded(Plan plan) = _PlanLoaded;

  const factory PlanState.error(Failure failure) = _Error;
}
