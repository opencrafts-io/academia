import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Describes why a subscription can or cannot currently grant access.
///
/// The API intentionally keeps these states separate from the server's raw
/// subscription status string. This gives callers a stable client-side
/// decision API even if the backend adds more status values later.
enum SubscriptionAccessState {
  /// The subscription is active and within its current billing period.
  active,

  /// The API reports that there is no active subscription.
  inactive,

  /// The response did not include a subscription object.
  noSubscription,

  /// The current time is before the subscription's current period start.
  notStarted,

  /// The current time is at or after the current period end.
  expired,
}

/// Applies the client-side subscription access policy.
///
/// Implement this interface when a product needs a different policy, such as
/// a grace period. The backend remains the final authority for authorization;
/// this policy exists to make local feature gating predictable and testable.
abstract interface class SubscriptionAccessPolicy {
  /// Evaluates whether [status] can grant entitlement access at [now].
  SubscriptionAccessState evaluate(
    SubscriptionStatus status,
    DateTime now,
  );
}

/// The default subscription access policy used by [BillingService].
///
/// Access requires all of the following:
///
/// 1. The API response has `active == true`.
/// 2. A subscription object is present.
/// 3. The current time is not before `current_period_start`.
/// 4. The current time is strictly before `current_period_end`.
///
/// `cancel_at_period_end` does not revoke access immediately. It indicates
/// that access should stop when the current period ends, which is already
/// represented by `current_period_end`. A non-null `cancelled_at` is also not
/// interpreted independently because the API's `active` value is the
/// authoritative state for this client-side check.
@LazySingleton(as: SubscriptionAccessPolicy)
class DefaultSubscriptionAccessPolicy implements SubscriptionAccessPolicy {
  const DefaultSubscriptionAccessPolicy();

  @override
  SubscriptionAccessState evaluate(
    SubscriptionStatus status,
    DateTime now,
  ) {
    if (!status.active) return SubscriptionAccessState.inactive;

    final subscription = status.subscription;
    if (subscription == null) return SubscriptionAccessState.noSubscription;

    if (now.isBefore(subscription.currentPeriodStart)) {
      return SubscriptionAccessState.notStarted;
    }
    if (!now.isBefore(subscription.currentPeriodEnd)) {
      return SubscriptionAccessState.expired;
    }

    return SubscriptionAccessState.active;
  }
}

/// Provides a single, testable source of the current time for billing checks.
///
/// Keeping the clock behind an interface prevents entitlement checks from
/// depending directly on wall-clock access and allows deterministic tests or
/// a product-specific time source to be supplied later.
abstract interface class BillingClock {
  /// Returns the current instant in UTC.
  DateTime now();
}

@LazySingleton(as: BillingClock)
class SystemBillingClock implements BillingClock {
  const SystemBillingClock();

  @override
  DateTime now() => DateTime.now().toUtc();
}

/// Explains the result of checking one entitlement.
///
/// Use [isGranted] for simple UI decisions. Use [state], [value], and
/// [subscription] when the UI needs to explain why access is unavailable or
/// display the user's current allowance.
enum EntitlementCheckState {
  /// The entitlement exists and satisfies the requested constraints.
  granted,

  /// The subscription is not active according to the API.
  subscriptionInactive,

  /// The API returned no subscription object.
  noSubscription,

  /// The subscription has not reached its current period start.
  subscriptionNotStarted,

  /// The current subscription period has ended.
  subscriptionExpired,

  /// No entitlement with the requested key exists for the active plan.
  entitlementMissing,

  /// The entitlement exists but its value is below the requested minimum.
  insufficientValue,

  /// The entitlement exists but has a different unit than requested.
  unitMismatch,
}

/// A stable result object returned by [BillingService.checkEntitlement].
class EntitlementCheck {
  /// Creates an entitlement check result.
  const EntitlementCheck({
    required this.key,
    required this.state,
    this.value,
    this.unit,
    this.subscription,
  });

  /// The entitlement key that was checked.
  final String key;

  /// The reason access was granted or denied.
  final EntitlementCheckState state;

  /// The server-provided entitlement value, when the entitlement exists.
  final int? value;

  /// The server-provided entitlement unit, when the entitlement exists.
  final String? unit;

  /// The subscription used for the check, when one was returned by the API.
  final Subscription? subscription;

  /// Whether this check grants access.
  bool get isGranted => state == EntitlementCheckState.granted;
}

/// Provides a developer-friendly API for checking the current user's access.
///
/// The service is remote-first through the existing billing repositories. If
/// the network is unavailable, those repositories use the Drift cache. The
/// service then keeps the result in memory for the lifetime of this instance,
/// avoiding repeated requests while a screen performs several checks.
///
/// This service does not perform checkout, charge orders, or mutate billing
/// state. Plan checkout belongs to the separate web application.
@LazySingleton()
class BillingService {
  /// Creates a billing service with replaceable policy and time dependencies.
  BillingService({
    required GetCurrentSubscriptionStatus getCurrentSubscriptionStatus,
    required GetEntitlementsByPlanCode getEntitlementsByPlanCode,
    required SubscriptionAccessPolicy accessPolicy,
    required BillingClock clock,
  }) : _getCurrentSubscriptionStatus = getCurrentSubscriptionStatus,
       _getEntitlementsByPlanCode = getEntitlementsByPlanCode,
       _accessPolicy = accessPolicy,
       _clock = clock;

  final GetCurrentSubscriptionStatus _getCurrentSubscriptionStatus;
  final GetEntitlementsByPlanCode _getEntitlementsByPlanCode;
  final SubscriptionAccessPolicy _accessPolicy;
  final BillingClock _clock;

  SubscriptionStatus? _cachedStatus;
  List<Entitlement>? _cachedEntitlements;
  String? _cachedEntitlementsPlanCode;

  /// Checks whether the current user has [key].
  ///
  /// By default, an entitlement must have a value of at least `1`. Pass
  /// [minimumValue] for quota-style entitlements, and [unit] when the same
  /// key can be expressed in different units. Set [forceRefresh] to bypass
  /// this service's in-memory values; the repository may still use its Drift
  /// cache when the network is unavailable.
  ///
  /// A successful call returns an [EntitlementCheck] even when access is
  /// denied. A [Failure] is returned only when subscription or entitlement
  /// data could not be obtained from either the remote API or local cache.
  ///
  /// ```dart
  /// final result = await billingService.checkEntitlement('advanced_search');
  /// result.fold(
  ///   (failure) => showBillingUnavailable(failure),
  ///   (check) {
  ///     if (check.isGranted) showAdvancedSearch();
  ///   },
  /// );
  /// ```
  Future<Either<Failure, EntitlementCheck>> checkEntitlement(
    String key, {
    int minimumValue = 1,
    String? unit,
    bool forceRefresh = false,
  }) async {
    final normalizedKey = key.trim();
    if (normalizedKey.isEmpty) {
      return const Left(
        Failure.validation(
          message: 'Entitlement key cannot be empty',
          code: 'ENTITLEMENT_KEY_REQUIRED',
        ),
      );
    }
    if (minimumValue < 1) {
      return const Left(
        Failure.validation(
          message: 'Entitlement minimum value must be at least 1',
          code: 'ENTITLEMENT_MINIMUM_VALUE_INVALID',
        ),
      );
    }

    final statusResult = await _loadSubscriptionStatus(forceRefresh);
    return statusResult.fold(
      Left.new,
      (status) async {
        final subscription = status.subscription;
        final accessState = _accessPolicy.evaluate(status, _clock.now());
        final denied = _deniedCheck(
          normalizedKey,
          accessState,
          subscription,
        );
        if (denied != null) return Right(denied);

        final entitlementsResult = await _loadEntitlements(
          subscription!.planCode,
          forceRefresh,
        );
        return entitlementsResult.fold(
          Left.new,
          (entitlements) {
            final entitlement = entitlements
                .where((item) => item.key == normalizedKey)
                .firstOrNull;

            if (entitlement == null) {
              return Right(
                EntitlementCheck(
                  key: normalizedKey,
                  state: EntitlementCheckState.entitlementMissing,
                  subscription: subscription,
                ),
              );
            }
            if (unit != null && entitlement.unit != unit) {
              return Right(
                EntitlementCheck(
                  key: normalizedKey,
                  state: EntitlementCheckState.unitMismatch,
                  value: entitlement.value,
                  unit: entitlement.unit,
                  subscription: subscription,
                ),
              );
            }
            if (entitlement.value < minimumValue) {
              return Right(
                EntitlementCheck(
                  key: normalizedKey,
                  state: EntitlementCheckState.insufficientValue,
                  value: entitlement.value,
                  unit: entitlement.unit,
                  subscription: subscription,
                ),
              );
            }

            return Right(
              EntitlementCheck(
                key: normalizedKey,
                state: EntitlementCheckState.granted,
                value: entitlement.value,
                unit: entitlement.unit,
                subscription: subscription,
              ),
            );
          },
        );
      },
    );
  }

  /// Returns whether [key] is currently available to the user.
  ///
  /// This convenience method fails closed and returns `false` if the billing
  /// API and local cache are both unavailable. Use [checkEntitlement] when
  /// the caller needs to distinguish unavailable billing data from denied
  /// access and show an appropriate retry state.
  Future<bool> hasEntitlement(
    String key, {
    int minimumValue = 1,
    String? unit,
    bool forceRefresh = false,
  }) async {
    final result = await checkEntitlement(
      key,
      minimumValue: minimumValue,
      unit: unit,
      forceRefresh: forceRefresh,
    );
    return result.fold((_) => false, (check) => check.isGranted);
  }

  /// Forces the next entitlement check to reload subscription data.
  ///
  /// This only clears the service's in-memory values. The repository still
  /// follows its normal remote-first and Drift-fallback behavior.
  void invalidate() {
    _cachedStatus = null;
    _cachedEntitlements = null;
    _cachedEntitlementsPlanCode = null;
  }

  Future<Either<Failure, SubscriptionStatus>> _loadSubscriptionStatus(
    bool forceRefresh,
  ) async {
    if (!forceRefresh && _cachedStatus != null) {
      return Right(_cachedStatus!);
    }

    final result = await _getCurrentSubscriptionStatus(
      const NoUseCaseParams(),
    );
    result.fold((_) {}, (status) => _cachedStatus = status);
    return result;
  }

  Future<Either<Failure, List<Entitlement>>> _loadEntitlements(
    String planCode,
    bool forceRefresh,
  ) async {
    if (!forceRefresh &&
        _cachedEntitlementsPlanCode == planCode &&
        _cachedEntitlements != null) {
      return Right(_cachedEntitlements!);
    }

    final result = await _getEntitlementsByPlanCode(planCode);
    result.fold(
      (_) {},
      (entitlements) {
        _cachedEntitlementsPlanCode = planCode;
        _cachedEntitlements = List.unmodifiable(entitlements);
      },
    );
    return result;
  }

  EntitlementCheck? _deniedCheck(
    String key,
    SubscriptionAccessState state,
    Subscription? subscription,
  ) {
    final checkState = switch (state) {
      SubscriptionAccessState.active => null,
      SubscriptionAccessState.inactive =>
        EntitlementCheckState.subscriptionInactive,
      SubscriptionAccessState.noSubscription =>
        EntitlementCheckState.noSubscription,
      SubscriptionAccessState.notStarted =>
        EntitlementCheckState.subscriptionNotStarted,
      SubscriptionAccessState.expired =>
        EntitlementCheckState.subscriptionExpired,
    };

    return checkState == null
        ? null
        : EntitlementCheck(
            key: key,
            state: checkState,
            subscription: subscription,
          );
  }
}
