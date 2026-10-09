import 'dart:async';

import 'package:billing/billing.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import 'banner_ad_size.dart';

typedef NoAdsEntitlementReader = Future<bool?> Function({bool forceRefresh});
typedef InterstitialAdLoader = Future<void> Function({
  required String adUnitId,
  required AdRequest request,
  required InterstitialAdLoadCallback adLoadCallback,
});

/// Owns ad eligibility and the lifecycle of the app's interstitial ad.
@LazySingleton()
class AdService {
  factory AdService({
    BillingService? billingService,
    NoAdsEntitlementReader? hasNoAdsEntitlement,
    FlavorConfig? flavor,
    TargetPlatform? platform,
    bool? isReleaseMode,
    InterstitialAdLoader? interstitialLoader,
  }) {
    return AdService._(
      billingService,
      hasNoAdsEntitlement,
      flavor,
      platform ?? defaultTargetPlatform,
      isReleaseMode ?? kReleaseMode,
      interstitialLoader ?? InterstitialAd.load,
    );
  }

  AdService._(
    this._billingService,
    this._hasNoAdsEntitlement,
    this._flavor,
    this._platform,
    this._isReleaseMode,
    this._interstitialLoader,
  );

  static const noAdsEntitlementKey = 'no_ads';

  final BillingService? _billingService;
  final NoAdsEntitlementReader? _hasNoAdsEntitlement;
  final FlavorConfig? _flavor;
  final TargetPlatform _platform;
  final bool _isReleaseMode;
  final InterstitialAdLoader _interstitialLoader;
  final ValueNotifier<bool> _adsAllowed = ValueNotifier(false);

  bool _initialized = false;
  bool _interstitialLoading = false;
  bool _showingInterstitial = false;
  int _interstitialGeneration = 0;
  int _eligibilityGeneration = 0;
  Future<bool>? _eligibilityCheckInFlight;
  Future<bool>? _refreshInFlight;
  InterstitialAd? _interstitialAd;

  ValueListenable<bool> get adsAllowed => _adsAllowed;

  Future<void> initialize() async {
    if (_initialized || !isSupportedPlatform) return;
    await MobileAds.instance.initialize();
    _initialized = true;
  }

  bool get isSupportedPlatform =>
      !kIsWeb &&
      (_platform == TargetPlatform.android || _platform == TargetPlatform.iOS);

  bool get _useLiveUnits => (_flavor?.isProduction ?? false) && _isReleaseMode;

  String? get bannerAdUnitID {
    if (!isSupportedPlatform) return null;
    if (_platform == TargetPlatform.android) {
      return _useLiveUnits
          ? 'ca-app-pub-4838989029590048/1220011077'
          : 'ca-app-pub-3940256099942544/6300978111';
    }
    return _useLiveUnits
        ? 'ca-app-pub-4838989029590048/6199098250'
        : 'ca-app-pub-3940256099942544/2934735716';
  }

  String? get interstitialAdUnitID {
    if (!isSupportedPlatform) return null;
    if (_platform == TargetPlatform.android) {
      return _useLiveUnits
          ? 'ca-app-pub-4838989029590048/8324475478'
          : 'ca-app-pub-3940256099942544/1033173712';
    }
    return _useLiveUnits
        ? 'ca-app-pub-4838989029590048/2523593032'
        : 'ca-app-pub-3940256099942544/4411468910';
  }

  Future<bool> canShowAds({bool forceRefresh = false}) {
    if (forceRefresh) return refreshEligibility();
    final refresh = _refreshInFlight;
    if (refresh != null) return refresh;
    final pending = _eligibilityCheckInFlight;
    if (pending != null) return pending;

    final check = _checkEligibility(forceRefresh: false);
    _eligibilityCheckInFlight = check;
    unawaited(
      check.whenComplete(() {
        if (identical(_eligibilityCheckInFlight, check)) {
          _eligibilityCheckInFlight = null;
        }
      }),
    );
    return check;
  }

  /// Rechecks the server after checkout or when the app resumes.
  Future<bool> refreshEligibility() {
    final pending = _refreshInFlight;
    if (pending != null) return pending;

    _adsAllowed.value = false;
    final refresh = _checkEligibility(forceRefresh: true);
    _refreshInFlight = refresh;
    unawaited(
      refresh.then((allowed) {
        if (identical(_refreshInFlight, refresh)) _refreshInFlight = null;
        if (allowed && _initialized) unawaited(loadInterstitialAd());
      }),
    );
    return refresh;
  }

  Future<bool> _checkEligibility({required bool forceRefresh}) async {
    final generation = ++_eligibilityGeneration;
    bool allowed;
    try {
      allowed =
          await _readNoAdsEntitlement(forceRefresh: forceRefresh) == false;
    } on Object {
      allowed = false;
    }

    if (generation != _eligibilityGeneration) return _adsAllowed.value;
    _adsAllowed.value = allowed;
    if (!allowed) _disposeInterstitial();
    return allowed;
  }

  Future<BannerAd?> createBannerAd({
    BannerAdSize size = BannerAdSize.banner,
    AdRequest? adRequest,
    BannerAdListener? bannerAdListener,
  }) async {
    if (!isSupportedPlatform || !await canShowAds()) return null;

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
    if (!isSupportedPlatform ||
        _interstitialLoading ||
        _showingInterstitial ||
        _interstitialAd != null) {
      return;
    }

    _interstitialLoading = true;
    final generation = ++_interstitialGeneration;
    try {
      final allowed = await canShowAds();
      final id = interstitialAdUnitID;
      if (!allowed || id == null || generation != _interstitialGeneration) {
        if (generation == _interstitialGeneration) _interstitialLoading = false;
        return;
      }

      await _interstitialLoader(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            if (generation != _interstitialGeneration || !_adsAllowed.value) {
              unawaited(ad.dispose());
              return;
            }
            _interstitialLoading = false;
            _interstitialAd = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: _finishInterstitial,
              onAdFailedToShowFullScreenContent: (ad, _) =>
                  _finishInterstitial(ad),
            );
          },
          onAdFailedToLoad: (_) {
            if (generation == _interstitialGeneration) {
              _interstitialLoading = false;
            }
          },
        ),
      );
    } on Object {
      if (generation == _interstitialGeneration) _interstitialLoading = false;
    }
  }

  Future<void> showInterstitialAd() async {
    if (!isSupportedPlatform || _showingInterstitial || !await canShowAds()) {
      return;
    }
    if (_showingInterstitial) return;

    final ad = _interstitialAd;
    if (ad == null) {
      await loadInterstitialAd();
      return;
    }

    _interstitialAd = null;
    _showingInterstitial = true;
    try {
      await ad.show();
    } on Object {
      _finishInterstitial(ad);
    }
  }

  Future<bool?> _readNoAdsEntitlement({required bool forceRefresh}) async {
    final reader = _hasNoAdsEntitlement;
    if (reader != null) return reader(forceRefresh: forceRefresh);

    final billingService = _billingService;
    if (billingService == null) return null;
    if (forceRefresh) {
      final status = await billingService.refreshSubscriptionStatus();
      if (status.isLeft()) return null;
    }

    final result = await billingService.checkEntitlement(noAdsEntitlementKey);
    return result.fold((_) => null, (check) => check.isGranted);
  }

  void _finishInterstitial(InterstitialAd ad) {
    if (!_showingInterstitial) return;
    _showingInterstitial = false;
    unawaited(ad.dispose());
    if (_adsAllowed.value) unawaited(loadInterstitialAd());
  }

  void _disposeInterstitial() {
    _interstitialGeneration++;
    _interstitialLoading = false;
    final ad = _interstitialAd;
    _interstitialAd = null;
    if (ad != null) unawaited(ad.dispose());
  }
}
