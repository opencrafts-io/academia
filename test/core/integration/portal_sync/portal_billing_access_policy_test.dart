import 'package:academia/core/integration/portal_sync/portal_billing_access_policy.dart';
import 'package:billing/billing.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('debug testers can analyze without a subscription lookup', () async {
    final status = _InactiveStatus();
    final access = PortalBillingAccessPolicy(
      getStatus: status,
      isCurrentAccount: () => true,
    );
    const bypass = bool.fromEnvironment(
      'PORTAL_BYPASS_SUBSCRIPTION',
      defaultValue: true,
    );
    expect(await access.canAnalyze(), bypass);
    expect(status.calls, bypass ? 0 : 1);
  });

  test('account changes still block access during testing', () async {
    final status = _InactiveStatus();
    final access = PortalBillingAccessPolicy(
      getStatus: status,
      isCurrentAccount: () => false,
    );
    expect(await access.canAnalyze(), isFalse);
    expect(status.calls, 0);
  });
}

class _InactiveStatus implements GetCurrentSubscriptionStatus {
  int calls = 0;

  @override
  Future<Either<Failure, SubscriptionStatus>> call(
    NoUseCaseParams params,
  ) async {
    calls++;
    return const Right(SubscriptionStatus(active: false, subscription: null));
  }
}
