part of 'ad_bloc.dart';

abstract class AdEvent extends Equatable {
  const AdEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAdMobEvent extends AdEvent {
  const InitializeAdMobEvent();
}

class LoadBannerAdEvent extends AdEvent {
  final String adUnitId;

  const LoadBannerAdEvent({required this.adUnitId});

  @override
  List<Object?> get props => [adUnitId];
}

class LoadInterstitialAdEvent extends AdEvent {
  final String adUnitId;

  const LoadInterstitialAdEvent({required this.adUnitId});

  @override
  List<Object?> get props => [adUnitId];
}

class LoadRewardedAdEvent extends AdEvent {
  final String adUnitId;

  const LoadRewardedAdEvent({required this.adUnitId});

  @override
  List<Object?> get props => [adUnitId];
}

class ShowInterstitialAdEvent extends AdEvent {
  final String adId;

  const ShowInterstitialAdEvent({required this.adId});

  @override
  List<Object?> get props => [adId];
}

class ShowRewardedAdEvent extends AdEvent {
  final String adId;

  const ShowRewardedAdEvent({required this.adId});

  @override
  List<Object?> get props => [adId];
}

class LoadLoadedAdsEvent extends AdEvent {
  const LoadLoadedAdsEvent();
}

class SetTestModeEvent extends AdEvent {
  final bool enabled;

  const SetTestModeEvent({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}
