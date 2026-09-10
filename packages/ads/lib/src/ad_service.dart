import 'dart:io';

import 'package:billing/billing.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import 'banner_ad_size.dart';

typedef NoAdsEntitlementReader = Future<bool> Function({bool forceRefresh});

/// Handles all ad-related operations.
///
/// Billing is checked before loading ads so subscribed users and users with
/// the `no_ads` entitlement do not pay the frame or network cost of ad views.
@LazySingleton()
class AdService {
  factory AdService({
    BillingService? billingService,
    NoAdsEntitlementReader? hasNoAdsEntitlement,
  }) {
    return AdService._(
      billingService: billingService,
      hasNoAdsEntitlement: hasNoAdsEntitlement,
    );
  }

  AdService._({this._billingService, this._hasNoAdsEntitlement});

  static const noAdsEntitlementKey = 'no_ads';

  final BillingService? _billingService;
  final NoAdsEntitlementReader? _hasNoAdsEntitlement;

  bool _initialized = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  Future<void> initialize() async {
    if (_initialized || !isSupportedPlatform) return;
    await MobileAds.instance.initialize();
    _initialized = true;
  }

  static bool get isSupportedPlatform {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  static String? get bannerAdUnitID {
    if (!isSupportedPlatform) return null;
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-4838989029590048/1220011077';
    }
    return 'ca-app-pub-4838989029590048/6199098250';
  }

  static String? get interstitialAdUnitID {
    if (!isSupportedPlatform) return null;
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-4838989029590048/8324475478';
    }
    return 'ca-app-pub-4838989029590048/2523593032';
  }

  Future<bool> canShowAds({bool forceRefresh = false}) async {
    final hasNoAds = await _readNoAdsEntitlement(forceRefresh: forceRefresh);
    return !hasNoAds;
  }

  Future<BannerAd?> createBannerAd({
    BannerAdSize size = BannerAdSize.banner,
    AdRequest? adRequest,
    BannerAdListener? bannerAdListener,
  }) async {
    if (!await canShowAds()) return null;

    final id = bannerAdUnitID;
    if (id == null) return null;

    return BannerAd(
      size: size.googleAdSize,
      request: adRequest ?? const AdRequest(),
      adUnitId: id,
      listener: bannerAdListener ?? const BannerAdListener(),
    )..load();
  }

  Future<void> loadInterstitialAd() async {
    if (!await canShowAds()) {
      _disposeInterstitial();
      return;
    }

    final id = interstitialAdUnitID;
    if (id == null) return;

    InterstitialAd.load(
      adUnitId: id,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _isInterstitialAdReady = false;
                  loadInterstitialAd();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  ad.dispose();
                  _isInterstitialAdReady = false;
                  loadInterstitialAd();
                },
              );
        },
        onAdFailedToLoad: (error) {
          _isInterstitialAdReady = false;
          _interstitialAd = null;
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (!await canShowAds()) {
      _disposeInterstitial();
      return;
    }

    if (_isInterstitialAdReady && _interstitialAd != null) {
      await _interstitialAd!.show();
    } else {
      await loadInterstitialAd();
    }
  }

  Future<bool> _readNoAdsEntitlement({required bool forceRefresh}) {
    final reader = _hasNoAdsEntitlement;
    if (reader != null) return reader(forceRefresh: forceRefresh);

    final billingService = _billingService;
    if (billingService == null) return Future.value(false);

    return billingService.hasEntitlement(
      noAdsEntitlementKey,
      forceRefresh: forceRefresh,
    );
  }

  void _disposeInterstitial() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isInterstitialAdReady = false;
  }
}
