import 'package:billing/billing.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:portal_sync/portal_sync.dart';

// Temporary tester access. Restore the debug gate with
// --dart-define=PORTAL_BYPASS_SUBSCRIPTION=false. Release/profile always gate.
const _bypassSubscription =
    kDebugMode &&
    bool.fromEnvironment('PORTAL_BYPASS_SUBSCRIPTION', defaultValue: true);

/// Internal release gate. Server entitlement enforcement follows in phase 3.
class PortalBillingAccessPolicy implements PortalAccessPolicy {
  PortalBillingAccessPolicy({
    required this.getStatus,
    required this.isCurrentAccount,
    this.policy = const DefaultSubscriptionAccessPolicy(),
  });

  final GetCurrentSubscriptionStatus getStatus;
  final SubscriptionAccessPolicy policy;
  final bool Function() isCurrentAccount;

  @override
  Future<bool> canAnalyze() async {
    if (!isCurrentAccount()) return false;
    if (_bypassSubscription) return true;
    final result = await getStatus(NoUseCaseParams());
    return isCurrentAccount() &&
        result.fold(
          (_) => false,
          (status) =>
              policy.evaluate(status, DateTime.now().toUtc()) ==
              SubscriptionAccessState.active,
        );
  }
}
