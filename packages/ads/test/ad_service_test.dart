import 'package:ads/ads.dart';
import 'package:billing/billing.dart';
import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  group('AdService.canShowAds', () {
    test('returns false when the user has the no_ads entitlement', () async {
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async => true,
      );

      expect(await service.canShowAds(), isFalse);
    });

    test(
      'returns true when the user does not have the no_ads entitlement',
      () async {
        final service = AdService(
          hasNoAdsEntitlement: ({bool forceRefresh = false}) async => false,
        );

        expect(await service.canShowAds(), isTrue);
      },
    );

    test('suppresses ads when entitlement verification fails', () async {
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async =>
            throw StateError('billing unavailable'),
      );

      expect(await service.canShowAds(), isFalse);
      expect(service.adsAllowed.value, isFalse);
    });

    test('refreshes eligibility after a subscription changes', () async {
      var hasNoAds = false;
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async => hasNoAds,
      );

      expect(await service.canShowAds(), isTrue);
      hasNoAds = true;

      expect(await service.refreshEligibility(), isFalse);
      expect(service.adsAllowed.value, isFalse);
    });

    test(
      'refreshes stale billing status before showing paid users ads',
      () async {
        final repository = _SubscriptionRepository();
        final billing = BillingService(
          getCurrentSubscriptionStatus: GetCurrentSubscriptionStatus(
            repository,
          ),
          getEntitlementsByPlanCode: GetEntitlementsByPlanCode(
            _EntitlementRepository(),
          ),
          accessPolicy: const DefaultSubscriptionAccessPolicy(),
          clock: _FixedClock(),
        );
        final service = AdService(billingService: billing);

        expect(await service.canShowAds(), isTrue);
        repository.status = _paidStatus();

        expect(await service.refreshEligibility(), isFalse);
        expect(repository.freshReads, 1);
        expect(service.adsAllowed.value, isFalse);
      },
    );

    test(
      'suppresses ads when fresh billing verification is unavailable',
      () async {
        final repository = _SubscriptionRepository();
        final billing = BillingService(
          getCurrentSubscriptionStatus: GetCurrentSubscriptionStatus(
            repository,
          ),
          getEntitlementsByPlanCode: GetEntitlementsByPlanCode(
            _EntitlementRepository(),
          ),
          accessPolicy: const DefaultSubscriptionAccessPolicy(),
          clock: _FixedClock(),
        );
        final service = AdService(billingService: billing);

        expect(await service.canShowAds(), isTrue);
        repository.freshUnavailable = true;

        expect(await service.refreshEligibility(), isFalse);
        expect(service.adsAllowed.value, isFalse);
      },
    );
  });

  group('AdService ad unit selection', () {
    test('uses test units for staging release builds', () {
      final service = AdService(
        flavor: _flavor(Flavor.staging),
        platform: TargetPlatform.android,
        isReleaseMode: true,
      );

      expect(service.bannerAdUnitID, 'ca-app-pub-3940256099942544/6300978111');
      expect(
        service.interstitialAdUnitID,
        'ca-app-pub-3940256099942544/1033173712',
      );
    });

    test('uses iOS test units in debug builds', () {
      final service = AdService(
        flavor: _flavor(Flavor.production),
        platform: TargetPlatform.iOS,
        isReleaseMode: false,
      );

      expect(service.bannerAdUnitID, 'ca-app-pub-3940256099942544/2934735716');
      expect(
        service.interstitialAdUnitID,
        'ca-app-pub-3940256099942544/4411468910',
      );
    });

    test('uses live units only for production release builds', () {
      final service = AdService(
        flavor: _flavor(Flavor.production),
        platform: TargetPlatform.android,
        isReleaseMode: true,
      );

      expect(service.bannerAdUnitID, 'ca-app-pub-4838989029590048/1220011077');
    });
  });

  group('AdService interstitial loading', () {
    test('keeps one load in flight and consumes a loaded ad once', () async {
      final callbacks = <InterstitialAdLoadCallback>[];
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async => false,
        flavor: _flavor(Flavor.staging),
        platform: TargetPlatform.android,
        interstitialLoader:
            ({
              required adUnitId,
              required request,
              required adLoadCallback,
            }) async {
              callbacks.add(adLoadCallback);
            },
      );

      await Future.wait([
        service.loadInterstitialAd(),
        service.loadInterstitialAd(),
      ]);
      expect(callbacks, hasLength(1));

      final ad = _FakeInterstitialAd();
      callbacks.single.onAdLoaded(ad);
      await service.loadInterstitialAd();
      expect(callbacks, hasLength(1));

      await Future.wait([
        service.showInterstitialAd(),
        service.showInterstitialAd(),
      ]);
      expect(ad.showCount, 1);
      ad.fullScreenContentCallback!.onAdDismissedFullScreenContent!(ad);
      await Future<void>.delayed(Duration.zero);
      expect(ad.disposeCount, 1);
      expect(callbacks, hasLength(2));
    });

    test('disposes a late load after ads become ineligible', () async {
      final callbacks = <InterstitialAdLoadCallback>[];
      var hasNoAds = false;
      final service = AdService(
        hasNoAdsEntitlement: ({bool forceRefresh = false}) async => hasNoAds,
        flavor: _flavor(Flavor.staging),
        platform: TargetPlatform.android,
        interstitialLoader:
            ({
              required adUnitId,
              required request,
              required adLoadCallback,
            }) async {
              callbacks.add(adLoadCallback);
            },
      );

      await service.loadInterstitialAd();
      hasNoAds = true;
      await service.refreshEligibility();
      final ad = _FakeInterstitialAd();
      callbacks.single.onAdLoaded(ad);

      expect(ad.disposeCount, 1);
      expect(service.adsAllowed.value, isFalse);
    });
  });

  group('BannerAdSize', () {
    test('keeps banner dimensions inside the ads package API', () {
      expect(BannerAdSize.banner.width, 320);
      expect(BannerAdSize.banner.height, 50);
    });
  });

  testWidgets('collapses the banner slot when ads are denied', (tester) async {
    final service = AdService(
      hasNoAdsEntitlement: ({bool forceRefresh = false}) async => true,
      platform: TargetPlatform.android,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Center(child: BannerAdWidget(adService: service)),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(BannerAdWidget)), Size.zero);
  });
}

FlavorConfig _flavor(Flavor flavor) => FlavorConfig(
  flavor: flavor,
  appName: 'Academia',
  apiBaseUrl: 'https://example.test',
);

class _FakeInterstitialAd implements InterstitialAd {
  @override
  FullScreenContentCallback<InterstitialAd>? fullScreenContentCallback;

  int showCount = 0;
  int disposeCount = 0;

  @override
  Future<void> show() async {
    showCount++;
  }

  @override
  Future<void> dispose() async {
    disposeCount++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _SubscriptionRepository implements SubscriptionRepository {
  SubscriptionStatus status = const SubscriptionStatus(
    active: false,
    subscription: null,
  );
  bool freshUnavailable = false;
  int freshReads = 0;

  @override
  Future<Either<Failure, SubscriptionStatus>> getCurrentStatus() async =>
      right(status);

  @override
  Future<Either<Failure, SubscriptionStatus>> refreshCurrentStatus() async {
    freshReads++;
    return freshUnavailable
        ? left(const Failure.network(message: 'offline'))
        : right(status);
  }
}

class _EntitlementRepository implements EntitlementRepository {
  @override
  Future<Either<Failure, List<Entitlement>>> getByPlanCode(
    String planCode,
  ) async => right([
    Entitlement(
      description: null,
      key: 'no_ads',
      planCode: planCode,
      unit: 'bool',
      value: 1,
      createdAt: DateTime.utc(2026, 10, 1),
      updatedAt: DateTime.utc(2026, 10, 1),
    ),
  ]);
}

class _FixedClock implements BillingClock {
  @override
  DateTime now() => DateTime.utc(2026, 10, 9);
}

SubscriptionStatus _paidStatus() => SubscriptionStatus(
  active: true,
  subscription: Subscription(
    id: 1,
    planCode: 'premium',
    planId: 1,
    planName: 'Premium',
    status: 'active',
    cancelAtPeriodEnd: false,
    cancelledAt: null,
    currentPeriodStart: DateTime.utc(2026, 10, 1),
    currentPeriodEnd: DateTime.utc(2026, 11, 1),
    startedAt: DateTime.utc(2026, 10, 1),
  ),
);
