import 'dart:async';

import 'package:billing/billing.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'banner_ad_size.dart';

typedef NoAdsEntitlementReader = Future<bool?> Function({bool forceRefresh});
typedef InterstitialAdLoader = Future<void> Function({
  required String adUnitId,
  required AdRequest request,
  required InterstitialAdLoadCallback adLoadCallback,
});

enum RewardedGenerationRequirement { required, notRequired, unavailable }

enum RewardedGenerationResult { earned, notRequired, dismissed, unavailable }

/// Owns ad eligibility and the lifecycle of app ads.
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
  static const _generationPointsKey = 'study_tools_generation_points';
  static const appOpenCooldown = Duration(hours: 4);
  static const fullscreenAdSeparation = Duration(minutes: 10);
  static const generationPointsPerRewardedAd = 3;

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
  bool _appOpenLoading = false;
  bool _showingAppOpenAd = false;
  bool _rewardedAdLoading = false;
  bool _showingRewardedAd = false;
  int _interstitialGeneration = 0;
  int _appOpenGeneration = 0;
  int _rewardedAdGeneration = 0;
  int _eligibilityGeneration = 0;
  Future<bool>? _eligibilityCheckInFlight;
  Future<bool>? _refreshInFlight;
  Future<RewardedInterstitialAd?>? _rewardedAdLoadInFlight;
  InterstitialAd? _interstitialAd;
  AppOpenAd? _appOpenAd;
  RewardedInterstitialAd? _rewardedAd;
  DateTime? _lastAppOpenShownAt;
  DateTime? _lastFullscreenAdShownAt;
  DateTime? _appOpenAdLoadedAt;
  int _generationPoints = 0;
  SharedPreferences? _generationPointsPreferences;

  ValueListenable<bool> get adsAllowed => _adsAllowed;
  int get generationPoints => _generationPoints;

  bool canSpendGenerationPoints(int points) =>
      points >= 0 && _generationPoints >= points;

  bool spendGenerationPoints(int points) {
    if (!canSpendGenerationPoints(points)) return false;
    _generationPoints -= points;
    _persistGenerationPoints();
    return true;
  }

  void refundGenerationPoints(int points) {
    if (points <= 0) return;
    _generationPoints += points;
    _persistGenerationPoints();
  }

  Future<void> initialize() async {
    if (_initialized || !isSupportedPlatform) return;
    try {
      _generationPointsPreferences = await SharedPreferences.getInstance();
      _generationPoints =
          _generationPointsPreferences?.getInt(_generationPointsKey) ?? 0;
    } on Object {
      _generationPoints = 0;
    }
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

  String? get appOpenAdUnitID {
    if (!isSupportedPlatform) return null;
    if (_platform == TargetPlatform.android) {
      return _useLiveUnits
          ? 'ca-app-pub-4838989029590048/4303370725'
          : 'ca-app-pub-3940256099942544/9257395921';
    }
    return _useLiveUnits ? null : 'ca-app-pub-3940256099942544/5575463023';
  }

  String? get rewardedAdUnitID {
    if (!isSupportedPlatform) return null;
    if (_platform == TargetPlatform.android) {
      return _useLiveUnits
          ? 'ca-app-pub-4838989029590048/8415763711'
          : 'ca-app-pub-3940256099942544/5354046379';
    }
    return _useLiveUnits ? null : 'ca-app-pub-3940256099942544/6978759866';
  }

  Future<bool> canShowAds() {
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
        if (allowed && _initialized) {
          unawaited(loadInterstitialAd());
          unawaited(loadAppOpenAd());
          unawaited(loadRewardedAd());
        }
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
    if (!allowed) {
      _disposeInterstitial();
      _disposeAppOpenAd();
      _disposeRewardedAd();
    }
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

  Future<void> loadAppOpenAd() async {
    if (!isSupportedPlatform ||
        !_initialized ||
        _appOpenLoading ||
        _showingAppOpenAd ||
        _appOpenAd != null) {
      return;
    }

    _appOpenLoading = true;
    final generation = ++_appOpenGeneration;
    try {
      final allowed = await canShowAds();
      final id = appOpenAdUnitID;
      if (!allowed || id == null || generation != _appOpenGeneration) {
        if (generation == _appOpenGeneration) _appOpenLoading = false;
        return;
      }

      await AppOpenAd.load(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            if (generation != _appOpenGeneration || !_adsAllowed.value) {
              unawaited(ad.dispose());
              return;
            }
            _appOpenLoading = false;
            _appOpenAd = ad;
            _appOpenAdLoadedAt = DateTime.now();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: _finishAppOpenAd,
              onAdFailedToShowFullScreenContent: (ad, _) =>
                  _finishAppOpenAd(ad),
            );
          },
          onAdFailedToLoad: (_) {
            if (generation == _appOpenGeneration) _appOpenLoading = false;
          },
        ),
      );
    } on Object {
      if (generation == _appOpenGeneration) _appOpenLoading = false;
    }
  }

  Future<void> loadRewardedAd() async {
    if (!isSupportedPlatform ||
        !_initialized ||
        _rewardedAdLoading ||
        _rewardedAd != null ||
        _showingRewardedAd ||
        !await canShowAds()) {
      return;
    }
    await _loadRewardedAd();
  }

  Future<RewardedGenerationRequirement>
  getRewardedGenerationRequirement() async {
    if (!isSupportedPlatform) return RewardedGenerationRequirement.notRequired;
    try {
      final hasNoAds = await _readNoAdsEntitlement(forceRefresh: false);
      if (hasNoAds == null) return RewardedGenerationRequirement.unavailable;
      if (hasNoAds) return RewardedGenerationRequirement.notRequired;
      if (rewardedAdUnitID == null) {
        return RewardedGenerationRequirement.notRequired;
      }
      if (!_initialized) {
        return RewardedGenerationRequirement.unavailable;
      }
      unawaited(loadRewardedAd());
      return RewardedGenerationRequirement.required;
    } on Object {
      return RewardedGenerationRequirement.unavailable;
    }
  }

  Future<RewardedGenerationResult> showRewardedGenerationAd({
    required bool acceptedByUser,
  }) async {
    if (!acceptedByUser) return RewardedGenerationResult.dismissed;
    if (_showingRewardedAd || _showingInterstitial || _showingAppOpenAd) {
      return RewardedGenerationResult.unavailable;
    }
    _showingRewardedAd = true;
    Completer<RewardedGenerationResult>? completion;

    try {
      final hasNoAds = await _readNoAdsEntitlement(forceRefresh: true);
      if (hasNoAds == null) return RewardedGenerationResult.unavailable;
      if (hasNoAds) return RewardedGenerationResult.notRequired;
      if (!isSupportedPlatform || !_initialized || rewardedAdUnitID == null) {
        return RewardedGenerationResult.unavailable;
      }
      _adsAllowed.value = true;

      final ad = await _loadRewardedAd();
      if (ad == null) return RewardedGenerationResult.unavailable;

      _rewardedAd = null;
      _lastFullscreenAdShownAt = DateTime.now();
      final adCompletion = Completer<RewardedGenerationResult>();
      completion = adCompletion;
      var rewardEarned = false;

      void finish(RewardedGenerationResult result) {
        if (adCompletion.isCompleted) return;
        _showingRewardedAd = false;
        unawaited(ad.dispose());
        adCompletion.complete(result);
        if (_adsAllowed.value) unawaited(loadRewardedAd());
      }

      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) => finish(
          rewardEarned
              ? RewardedGenerationResult.earned
              : RewardedGenerationResult.dismissed,
        ),
        onAdFailedToShowFullScreenContent: (ad, _) =>
            finish(RewardedGenerationResult.unavailable),
      );

      try {
        await ad.show(
          onUserEarnedReward: (_, _) {
            if (rewardEarned) return;
            rewardEarned = true;
            _generationPoints += generationPointsPerRewardedAd;
            _persistGenerationPoints();
          },
        );
      } on Object {
        finish(RewardedGenerationResult.unavailable);
      }
      return await adCompletion.future;
    } on Object {
      return RewardedGenerationResult.unavailable;
    } finally {
      if (completion == null) _showingRewardedAd = false;
    }
  }

  /// Rechecks subscription eligibility and shows a ready App Open ad on return.
  Future<void> onAppResumed() async {
    if (!isSupportedPlatform || !await refreshEligibility()) return;
    await showAppOpenAdIfAvailable();
  }

  Future<void> showAppOpenAdIfAvailable() async {
    if (!isSupportedPlatform ||
        _showingAppOpenAd ||
        _showingInterstitial ||
        _showingRewardedAd ||
        !await canShowAds()) {
      return;
    }

    final now = DateTime.now();
    final lastShownAt = _lastAppOpenShownAt;
    if (lastShownAt != null && now.difference(lastShownAt) < appOpenCooldown) {
      return;
    }
    final lastFullscreenAt = _lastFullscreenAdShownAt;
    if (lastFullscreenAt != null &&
        now.difference(lastFullscreenAt) < fullscreenAdSeparation) {
      return;
    }

    final ad = _appOpenAd;
    final loadedAt = _appOpenAdLoadedAt;
    if (ad == null ||
        loadedAt == null ||
        now.difference(loadedAt) >= appOpenCooldown) {
      if (ad != null) _disposeAppOpenAd();
      await loadAppOpenAd();
      return;
    }

    _appOpenAd = null;
    _appOpenAdLoadedAt = null;
    _showingAppOpenAd = true;
    _lastAppOpenShownAt = now;
    _lastFullscreenAdShownAt = now;
    try {
      await ad.show();
    } on Object {
      _finishAppOpenAd(ad);
    }
  }

  Future<void> showInterstitialAd() async {
    if (!isSupportedPlatform ||
        _showingInterstitial ||
        _showingAppOpenAd ||
        _showingRewardedAd ||
        !await canShowAds()) {
      return;
    }

    final lastFullscreenAt = _lastFullscreenAdShownAt;
    if (lastFullscreenAt != null &&
        DateTime.now().difference(lastFullscreenAt) < fullscreenAdSeparation) {
      return;
    }

    final ad = _interstitialAd;
    if (ad == null) {
      await loadInterstitialAd();
      return;
    }

    _interstitialAd = null;
    _showingInterstitial = true;
    _lastFullscreenAdShownAt = DateTime.now();
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

  Future<RewardedInterstitialAd?> _loadRewardedAd() async {
    final loaded = _rewardedAd;
    if (loaded != null) return loaded;
    final pending = _rewardedAdLoadInFlight;
    if (pending != null) return pending;

    final id = rewardedAdUnitID;
    if (id == null) return null;

    final generation = ++_rewardedAdGeneration;
    final completer = Completer<RewardedInterstitialAd?>();
    final loadFuture = completer.future;
    _rewardedAdLoading = true;
    _rewardedAdLoadInFlight = loadFuture;

    void complete(RewardedInterstitialAd? ad) {
      if (generation != _rewardedAdGeneration) {
        if (ad != null) unawaited(ad.dispose());
        if (!completer.isCompleted) completer.complete(null);
        return;
      }
      _rewardedAdLoading = false;
      if (identical(_rewardedAdLoadInFlight, loadFuture)) {
        _rewardedAdLoadInFlight = null;
      }
      if (!completer.isCompleted) completer.complete(ad);
    }

    try {
      await RewardedInterstitialAd.load(
        adUnitId: id,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            if (!_adsAllowed.value) {
              complete(null);
              unawaited(ad.dispose());
              return;
            }
            _rewardedAd = ad;
            complete(ad);
          },
          onAdFailedToLoad: (_) => complete(null),
        ),
      );
    } on Object {
      complete(null);
    }
    return loadFuture;
  }

  void _persistGenerationPoints() {
    final preferences = _generationPointsPreferences;
    if (preferences != null) {
      unawaited(preferences.setInt(_generationPointsKey, _generationPoints));
    }
  }

  void _finishInterstitial(InterstitialAd ad) {
    if (!_showingInterstitial) return;
    _showingInterstitial = false;
    unawaited(ad.dispose());
    if (_adsAllowed.value) unawaited(loadInterstitialAd());
  }

  void _finishAppOpenAd(AppOpenAd ad) {
    if (!_showingAppOpenAd) return;
    _showingAppOpenAd = false;
    unawaited(ad.dispose());
    if (_adsAllowed.value) unawaited(loadAppOpenAd());
  }

  void _disposeInterstitial() {
    _interstitialGeneration++;
    _interstitialLoading = false;
    final ad = _interstitialAd;
    _interstitialAd = null;
    if (ad != null) unawaited(ad.dispose());
  }

  void _disposeAppOpenAd() {
    _appOpenGeneration++;
    _appOpenLoading = false;
    _appOpenAdLoadedAt = null;
    final ad = _appOpenAd;
    _appOpenAd = null;
    if (ad != null) unawaited(ad.dispose());
  }

  void _disposeRewardedAd() {
    _rewardedAdGeneration++;
    _rewardedAdLoading = false;
    _rewardedAdLoadInFlight = null;
    final ad = _rewardedAd;
    _rewardedAd = null;
    if (ad != null) unawaited(ad.dispose());
  }
}
