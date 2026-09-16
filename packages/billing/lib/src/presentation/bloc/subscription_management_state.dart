import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';

enum SubscriptionManagementStatus {
  initial,
  loading,
  ready,
  creatingOrder,
  orderReady,
  creatingCheckoutSession,
  checkoutSessionReady,
  failure,
}

/// The presentation state for the plan selection and order preview flow.
class SubscriptionManagementState {
  const SubscriptionManagementState({
    this.status = SubscriptionManagementStatus.initial,
    this.plans = const [],
    this.subscriptionStatus,
    this.selectedPlan,
    this.order,
    this.orderItems = const [],
    this.checkoutSession,
    this.failure,
  });

  final SubscriptionManagementStatus status;
  final List<Plan> plans;
  final SubscriptionStatus? subscriptionStatus;
  final Plan? selectedPlan;
  final Order? order;
  final List<OrderItem> orderItems;
  final CheckoutSession? checkoutSession;
  final Failure? failure;

  bool get hasOrder => order != null;

  SubscriptionManagementState copyWith({
    SubscriptionManagementStatus? status,
    List<Plan>? plans,
    SubscriptionStatus? subscriptionStatus,
    Plan? selectedPlan,
    bool clearSelectedPlan = false,
    Order? order,
    bool clearOrder = false,
    List<OrderItem>? orderItems,
    CheckoutSession? checkoutSession,
    bool clearCheckoutSession = false,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return SubscriptionManagementState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      selectedPlan: clearSelectedPlan
          ? null
          : selectedPlan ?? this.selectedPlan,
      order: clearOrder ? null : order ?? this.order,
      orderItems: orderItems ?? this.orderItems,
      checkoutSession: clearCheckoutSession
          ? null
          : checkoutSession ?? this.checkoutSession,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
