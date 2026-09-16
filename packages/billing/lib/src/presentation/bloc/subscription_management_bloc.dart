import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'subscription_management_event.dart';
import 'subscription_management_state.dart';

@injectable
class SubscriptionManagementBloc
    extends Bloc<SubscriptionManagementEvent, SubscriptionManagementState> {
  SubscriptionManagementBloc(
    this._getPlans,
    this._getCurrentSubscriptionStatus,
    this._createOrder,
    this._createOrderItem,
    this._createCheckoutSession,
  ) : super(const SubscriptionManagementState()) {
    on<LoadSubscriptionManagement>(_load);
    on<RefreshSubscriptionManagement>(_load);
    on<SelectSubscriptionPlan>(_selectPlan);
    on<CreateSubscriptionOrder>(_createSubscriptionOrder);
    on<ClearSubscriptionOrder>(_clearOrder);
    on<RequestCheckoutSession>(_createCheckoutSessionRequest);
  }

  final GetPlans _getPlans;
  final GetCurrentSubscriptionStatus _getCurrentSubscriptionStatus;
  final CreateOrder _createOrder;
  final CreateOrderItem _createOrderItem;
  final CreateCheckoutSession _createCheckoutSession;

  Future<void> _load(
    SubscriptionManagementEvent event,
    Emitter<SubscriptionManagementState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.loading,
        clearFailure: true,
      ),
    );

    final plansResult = await _getPlans(const NoUseCaseParams());
    final subscriptionResult = await _getCurrentSubscriptionStatus(
      const NoUseCaseParams(),
    );
    if (isClosed) return;

    final plans = plansResult.getOrElse(() => const <Plan>[]);
    final subscriptionStatus = subscriptionResult.toOption().toNullable();
    final failure =
        plansResult.fold((value) => value, (_) => null) ??
        subscriptionResult.fold((value) => value, (_) => null);

    if (failure != null) {
      emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          plans: plans.isEmpty ? state.plans : plans,
          subscriptionStatus: subscriptionStatus,
          failure: failure,
        ),
      );
      return;
    }

    final selectedPlan = state.selectedPlan == null
        ? null
        : plans
              .where((plan) => plan.code == state.selectedPlan!.code)
              .firstOrNull;
    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.ready,
        plans: plans,
        subscriptionStatus: subscriptionStatus,
        selectedPlan: selectedPlan,
        clearOrder: true,
        orderItems: const [],
        clearCheckoutSession: true,
        clearFailure: true,
      ),
    );
  }

  void _selectPlan(
    SelectSubscriptionPlan event,
    Emitter<SubscriptionManagementState> emit,
  ) {
    if (!event.plan.active || !event.plan.visible) return;
    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.ready,
        selectedPlan: event.plan,
        clearOrder: true,
        orderItems: const [],
        clearCheckoutSession: true,
        clearFailure: true,
      ),
    );
  }

  Future<void> _createSubscriptionOrder(
    CreateSubscriptionOrder event,
    Emitter<SubscriptionManagementState> emit,
  ) async {
    final plan = state.selectedPlan;
    if (plan == null) {
      emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          failure: const Failure.validation(
            message: 'Select a plan before continuing',
            code: 'BILLING_PLAN_REQUIRED',
          ),
        ),
      );
      return;
    }
    final planId = plan.id;
    if (planId == null) {
      emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          failure: const Failure.validation(
            message: 'This plan is missing its server identifier',
            code: 'BILLING_PLAN_ID_REQUIRED',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.creatingOrder,
        clearCheckoutSession: true,
        clearFailure: true,
      ),
    );
    final orderResult = await _createOrder(
      CreateOrderRequest(
        currency: plan.currency,
        expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 30)),
      ),
    );
    if (isClosed) return;

    final order = orderResult.toOption().toNullable();
    final orderFailure = orderResult.fold((value) => value, (_) => null);
    if (orderFailure != null || order == null) {
      emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          failure: orderFailure,
        ),
      );
      return;
    }

    final itemResult = await _createOrderItem(
      CreateOrderItemRequest(
        orderId: order.id,
        planId: planId,
        quantity: 1,
        unitPrice: plan.price,
      ),
    );
    if (isClosed) return;

    itemResult.fold(
      (failure) => emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          order: order,
          failure: failure,
        ),
      ),
      (item) => emit(
        state.copyWith(
          status: SubscriptionManagementStatus.orderReady,
          order: order,
          orderItems: [item],
          clearFailure: true,
        ),
      ),
    );
  }

  void _clearOrder(
    ClearSubscriptionOrder event,
    Emitter<SubscriptionManagementState> emit,
  ) {
    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.ready,
        clearOrder: true,
        orderItems: const [],
        clearCheckoutSession: true,
        clearFailure: true,
      ),
    );
  }

  Future<void> _createCheckoutSessionRequest(
    RequestCheckoutSession event,
    Emitter<SubscriptionManagementState> emit,
  ) async {
    final order = state.order;
    if (order == null) {
      emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          failure: const Failure.validation(
            message: 'Create an order before starting checkout',
            code: 'BILLING_ORDER_REQUIRED',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SubscriptionManagementStatus.creatingCheckoutSession,
        clearCheckoutSession: true,
        clearFailure: true,
      ),
    );
    final result = await _createCheckoutSession(
      CreateCheckoutSessionRequest(orderId: order.id),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SubscriptionManagementStatus.failure,
          failure: failure,
        ),
      ),
      (session) => emit(
        state.copyWith(
          status: SubscriptionManagementStatus.checkoutSessionReady,
          checkoutSession: session,
          clearFailure: true,
        ),
      ),
    );
  }
}
