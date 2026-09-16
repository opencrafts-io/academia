import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'plan_state.dart';

@LazySingleton()
class PlanCubit extends Cubit<PlanState> {
  PlanCubit(this._getPlans, this._getPlanByCode)
    : super(const PlanState.initial());

  final GetPlans _getPlans;
  final GetPlanByCode _getPlanByCode;

  /// Fetches all plans and emits [PlanState.plansLoaded] or
  /// [PlanState.error].
  Future<void> getPlans() async {
    emit(const PlanState.loading());

    final result = await _getPlans(const NoUseCaseParams());
    if (isClosed) return;

    result.fold(
      (failure) => emit(PlanState.error(failure)),
      (plans) => emit(PlanState.plansLoaded(plans)),
    );
  }

  /// Fetches a single plan by [code] and emits [PlanState.planLoaded] or
  /// [PlanState.error].
  Future<void> getPlanByCode(String code) async {
    emit(const PlanState.loading());

    final result = await _getPlanByCode(code);
    if (isClosed) return;

    result.fold(
      (failure) => emit(PlanState.error(failure)),
      (plan) => emit(PlanState.planLoaded(plan)),
    );
  }
}
