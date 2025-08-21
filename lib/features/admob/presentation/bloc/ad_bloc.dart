import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final InitializeAdMobUsecase initializeAdMobUsecase;
  final LoadBannerAdUsecase loadBannerAdUsecase;
  final LoadInterstitialAdUsecase loadInterstitialAdUsecase;
  final LoadRewardedAdUsecase loadRewardedAdUsecase;
  final ShowInterstitialAdUsecase showInterstitialAdUsecase;
  final ShowRewardedAdUsecase showRewardedAdUsecase;
  final GetLoadedAdsUsecase getLoadedAdsUsecase;
  final SetTestModeUsecase setTestModeUsecase;

  final Logger _logger = Logger();

  AdBloc({
    required this.initializeAdMobUsecase,
    required this.loadBannerAdUsecase,
    required this.loadInterstitialAdUsecase,
    required this.loadRewardedAdUsecase,
    required this.showInterstitialAdUsecase,
    required this.showRewardedAdUsecase,
    required this.getLoadedAdsUsecase,
    required this.setTestModeUsecase,
  }) : super(AdInitialState()) {
    on<InitializeAdMobEvent>(_onInitializeAdMob);
    on<LoadBannerAdEvent>(_onLoadBannerAd);
    on<LoadInterstitialAdEvent>(_onLoadInterstitialAd);
    on<LoadRewardedAdEvent>(_onLoadRewardedAd);
    on<ShowInterstitialAdEvent>(_onShowInterstitialAd);
    on<ShowRewardedAdEvent>(_onShowRewardedAd);
    on<LoadLoadedAdsEvent>(_onLoadLoadedAds);
    on<SetTestModeEvent>(_onSetTestMode);
  }

  Future<void> _onInitializeAdMob(
    InitializeAdMobEvent event,
    Emitter<AdState> emit,
  ) async {
    emit(AdLoadingState());

    final result = await initializeAdMobUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to initialize AdMob', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (_) {
        _logger.d('AdMob initialized successfully');
        emit(AdInitializedState());
      },
    );
  }

  Future<void> _onLoadBannerAd(
    LoadBannerAdEvent event,
    Emitter<AdState> emit,
  ) async {
    emit(AdLoadingState());

    final params = LoadBannerAdParams(adUnitId: event.adUnitId);
    final result = await loadBannerAdUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to load banner ad', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (ad) {
        _logger.d('Banner ad loaded: ${ad.id}');
        emit(BannerAdLoadedState(ad: ad));
      },
    );
  }

  Future<void> _onLoadInterstitialAd(
    LoadInterstitialAdEvent event,
    Emitter<AdState> emit,
  ) async {
    emit(AdLoadingState());

    final params = LoadInterstitialAdParams(adUnitId: event.adUnitId);
    final result = await loadInterstitialAdUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to load interstitial ad', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (ad) {
        _logger.d('Interstitial ad loaded: ${ad.id}');
        emit(InterstitialAdLoadedState(ad: ad));
      },
    );
  }

  Future<void> _onLoadRewardedAd(
    LoadRewardedAdEvent event,
    Emitter<AdState> emit,
  ) async {
    emit(AdLoadingState());

    final params = LoadRewardedAdParams(adUnitId: event.adUnitId);
    final result = await loadRewardedAdUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to load rewarded ad', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (ad) {
        _logger.d('Rewarded ad loaded: ${ad.id}');
        emit(RewardedAdLoadedState(ad: ad));
      },
    );
  }

  Future<void> _onShowInterstitialAd(
    ShowInterstitialAdEvent event,
    Emitter<AdState> emit,
  ) async {
    final params = ShowInterstitialAdParams(adId: event.adId);
    final result = await showInterstitialAdUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to show interstitial ad', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (_) {
        _logger.d('Interstitial ad shown: ${event.adId}');
        emit(InterstitialAdShownState(adId: event.adId));
      },
    );
  }

  Future<void> _onShowRewardedAd(
    ShowRewardedAdEvent event,
    Emitter<AdState> emit,
  ) async {
    final params = ShowRewardedAdParams(adId: event.adId);
    final result = await showRewardedAdUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to show rewarded ad', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (_) {
        _logger.d('Rewarded ad shown: ${event.adId}');
        emit(RewardedAdShownState(adId: event.adId));
      },
    );
  }

  Future<void> _onLoadLoadedAds(
    LoadLoadedAdsEvent event,
    Emitter<AdState> emit,
  ) async {
    emit(AdLoadingState());

    final result = await getLoadedAdsUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to load ads', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (ads) {
        _logger.d('Loaded ${ads.length} ads');
        emit(AdsLoadedState(ads: ads));
      },
    );
  }

  Future<void> _onSetTestMode(
    SetTestModeEvent event,
    Emitter<AdState> emit,
  ) async {
    final params = SetTestModeParams(enabled: event.enabled);
    final result = await setTestModeUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to set test mode', error: failure.error);
        emit(AdErrorState(message: failure.message));
      },
      (_) {
        _logger.d('Test mode set: ${event.enabled}');
        emit(TestModeSetState(enabled: event.enabled));
      },
    );
  }
}
