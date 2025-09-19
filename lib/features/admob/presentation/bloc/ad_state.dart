part of 'ad_bloc.dart';

abstract class AdState extends Equatable {
  const AdState();

  @override
  List<Object?> get props => [];
}

class AdInitialState extends AdState {}

class AdLoadingState extends AdState {}

class AdInitializedState extends AdState {}

class BannerAdLoadedState extends AdState {
  final AdEntity ad;

  const BannerAdLoadedState({required this.ad});

  @override
  List<Object?> get props => [ad];
}

class InterstitialAdLoadedState extends AdState {
  final AdEntity ad;

  const InterstitialAdLoadedState({required this.ad});

  @override
  List<Object?> get props => [ad];
}

class RewardedAdLoadedState extends AdState {
  final AdEntity ad;

  const RewardedAdLoadedState({required this.ad});

  @override
  List<Object?> get props => [ad];
}

class InterstitialAdShownState extends AdState {
  final String adId;

  const InterstitialAdShownState({required this.adId});

  @override
  List<Object?> get props => [adId];
}

class RewardedAdShownState extends AdState {
  final String adId;

  const RewardedAdShownState({required this.adId});

  @override
  List<Object?> get props => [adId];
}

class AdsLoadedState extends AdState {
  final List<AdEntity> ads;

  const AdsLoadedState({required this.ads});

  @override
  List<Object?> get props => [ads];
}

class TestModeSetState extends AdState {
  final bool enabled;

  const TestModeSetState({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class AdErrorState extends AdState {
  final String message;

  const AdErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
