import 'package:billing/src/domain/domain.dart';

sealed class SubscriptionManagementEvent {
  const SubscriptionManagementEvent();
}

class LoadSubscriptionManagement extends SubscriptionManagementEvent {
  const LoadSubscriptionManagement();
}

class RefreshSubscriptionManagement extends SubscriptionManagementEvent {
  const RefreshSubscriptionManagement();
}

class SelectSubscriptionPlan extends SubscriptionManagementEvent {
  const SelectSubscriptionPlan(this.plan);

  final Plan plan;
}

class CreateSubscriptionOrder extends SubscriptionManagementEvent {
  const CreateSubscriptionOrder();
}

class ClearSubscriptionOrder extends SubscriptionManagementEvent {
  const ClearSubscriptionOrder();
}

class RequestCheckoutSession extends SubscriptionManagementEvent {
  const RequestCheckoutSession();
}
