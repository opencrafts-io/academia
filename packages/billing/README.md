# Billing

Billing is the Academia Flutter package for subscription plans, orders,
entitlements, and paywall UI. It wraps the billing API behind repositories,
use cases, BLoCs/cubits, routes, and a small `BillingService` that app features
can use to gate access.

The package is intended to be consumed from the main app through:

```dart
import 'package:billing/billing.dart';
```

## What It Provides

- Plan loading and plan detail lookup.
- Current subscription status lookup.
- Entitlement lookup by plan code.
- Order and order item creation for subscription checkout handoff.
- A `/billing` paywall route and supporting subscription management UI.
- `BillingService`, a developer-facing entitlement checker for feature gates.

## Integration

Add the package as a path dependency in the host app:

```yaml
dependencies:
  billing:
    path: packages/billing/
```

Register billing dependencies after `core` and `database`, because the billing
repositories depend on shared networking/failure types and Drift-backed local
cache tables:

```dart
import 'package:billing/billing.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
void configureDependencies(GetIt getIt) {
  configureCoreDependencies(getIt);
  configureLocalDatabaseDependencies(getIt);
  configureBillingDependencies(getIt);
}
```

Expose the package routes from the app router:

```dart
import 'package:billing/billing.dart' as billing;
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    ...$appRoutes,
    ...billing.routes,
  ],
);
```

The package currently contributes `PaywallRoute` at `/billing`.

## API Paths

Billing API paths are centralized in `BillingApiPaths`.

In debug builds, requests use the `/qa-verisafe` prefix. In release builds,
requests use `/verisafe`.

| Capability | Path |
| --- | --- |
| Plans | `/qa-verisafe/plans` or `/verisafe/plans` |
| Orders | `/qa-verisafe/orders` or `/verisafe/orders` |
| Order items | `/orders/{orderId}/items` under the active prefix |
| Current subscription | `/subscriptions/me` under the active prefix |
| Entitlements | `/entitlements/{planCode}` under the active prefix |

## Common Uses

### Show the Paywall

Use the generated route when app code needs to send a user to billing:

```dart
const PaywallRoute().go(context);
```

The route creates a `SubscriptionManagementBloc`, loads plans and the current
subscription status, and renders `PaywallPage`.

### Load Plans

Use `PlanCubit` when building a screen or widget that only needs plan data:

```dart
final cubit = getIt<PlanCubit>()..getPlans();
```

`PlanCubit.getPlans()` emits `PlanState.plansLoaded`. Use
`PlanCubit.getPlanByCode(code)` when a view needs one plan.

### Manage Subscription Checkout State

Use `SubscriptionManagementBloc` for the package paywall flow. It can:

- load plans and current subscription status;
- select an active, visible plan;
- create an order;
- create the order item for the selected plan;
- clear the pending order state.

Creating an order does not complete payment by itself. Checkout/payment is
handled outside this package by the web billing flow.

### Call Use Cases Directly

Use cases are exported for application services or orchestration code that
needs lower-level access:

```dart
final plans = await getIt<GetPlans>()(const NoUseCaseParams());
final status = await getIt<GetCurrentSubscriptionStatus>()(
  const NoUseCaseParams(),
);
final entitlements = await getIt<GetEntitlementsByPlanCode>()('pro');
```

Most use cases return `Future<Either<Failure, T>>`. Prefer handling both sides
explicitly so UI can distinguish an unavailable billing system from an empty or
denied subscription.

## Billing Service

`BillingService` is the preferred API for feature gates. It checks the current
user's subscription and plan entitlements and returns a stable
`EntitlementCheck` result.

Use it from feature code when the question is, "Can this user access this
capability?"

```dart
final billingService = getIt<BillingService>();

final result = await billingService.checkEntitlement('advanced_search');

result.fold(
  (failure) {
    // Billing data could not be loaded from the API or local cache.
    showRetryState(failure);
  },
  (check) {
    if (check.isGranted) {
      showAdvancedSearch();
    } else {
      const PaywallRoute().go(context);
    }
  },
);
```

For simple gates that should fail closed, use `hasEntitlement`:

```dart
final canExport = await getIt<BillingService>().hasEntitlement(
  'exports',
  minimumValue: 1,
);
```

### Entitlement Values and Units

Entitlements include a `key`, `value`, and `unit`. Use `minimumValue` for
quota-like capabilities and `unit` when a key may be represented in different
units:

```dart
final result = await getIt<BillingService>().checkEntitlement(
  'storage',
  minimumValue: 10,
  unit: 'gb',
);
```

The returned `EntitlementCheck.state` explains the decision:

| State | Meaning |
| --- | --- |
| `granted` | The subscription is active and the entitlement satisfies the requested value/unit. |
| `subscriptionInactive` | The API says the user has no active subscription. |
| `noSubscription` | The API returned no subscription object. |
| `subscriptionNotStarted` | The current time is before the subscription period start. |
| `subscriptionExpired` | The current subscription period has ended. |
| `entitlementMissing` | The active plan does not include the requested key. |
| `insufficientValue` | The entitlement exists but is below `minimumValue`. |
| `unitMismatch` | The entitlement exists but uses a different unit. |

### Caching and Refresh

Billing repositories are remote-first. On successful remote responses they
cache data locally through Drift. If the remote API is unavailable, they fall
back to the local cache.

`BillingService` adds an in-memory cache for the lifetime of the service
instance so a screen can perform several entitlement checks without repeating
the same subscription and entitlement requests.

Use `forceRefresh` to bypass the service's in-memory values for one check:

```dart
final check = await getIt<BillingService>().checkEntitlement(
  'advanced_search',
  forceRefresh: true,
);
```

Use `invalidate()` after events that may change subscription state, such as a
checkout callback, sign-in change, or manual refresh:

```dart
getIt<BillingService>().invalidate();
```

### Access Policy

`BillingService` uses `SubscriptionAccessPolicy` to decide whether a
subscription can grant access. The default policy grants access only when:

- `SubscriptionStatus.active` is `true`;
- a subscription object is present;
- the current time is not before `currentPeriodStart`;
- the current time is before `currentPeriodEnd`.

`cancelAtPeriodEnd` does not revoke access immediately. Access continues until
`currentPeriodEnd`.

Register another `SubscriptionAccessPolicy` if a product needs different
client-side behavior, such as a grace period. The backend remains the final
authority for authorization.

## Development

Run package tests from the package directory:

```sh
cd packages/billing
flutter test
```

Regenerate generated files after changing injectable registrations, routes,
Freezed models, JSON DTOs, or FlutterGen assets:

```sh
cd packages/billing
dart run build_runner build --delete-conflicting-outputs
```
