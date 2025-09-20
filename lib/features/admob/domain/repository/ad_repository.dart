import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

abstract class AdRepository {
  /// Initialize AdMob SDK
  Future<Either<Failure, void>> initializeAdMob();
  
  /// Load a banner ad
  Future<Either<Failure, AdEntity>> loadBannerAd(String adUnitId);
  
  /// Load an interstitial ad
  Future<Either<Failure, AdEntity>> loadInterstitialAd(String adUnitId);
  
  /// Load a rewarded ad
  Future<Either<Failure, AdEntity>> loadRewardedAd(String adUnitId);
  
  /// Load a native ad
  Future<Either<Failure, AdEntity>> loadNativeAd(String adUnitId);
  
  /// Show an interstitial ad
  Future<Either<Failure, void>> showInterstitialAd(String adId);
  
  /// Show a rewarded ad
  Future<Either<Failure, void>> showRewardedAd(String adId);
  
  /// Dispose an ad
  Future<Either<Failure, void>> disposeAd(String adId);
  
  /// Get ad status
  Future<Either<Failure, AdStatus>> getAdStatus(String adId);
  
  /// Check if ad is ready to show
  Future<Either<Failure, bool>> isAdReady(String adId);
  
  /// Get all loaded ads
  Future<Either<Failure, List<AdEntity>>> getLoadedAds();
  
  /// Clear all ads
  Future<Either<Failure, void>> clearAllAds();
  
  /// Set test mode
  Future<Either<Failure, void>> setTestMode(bool enabled);
  
  /// Get test mode status
  Future<Either<Failure, bool>> getTestMode();
}
