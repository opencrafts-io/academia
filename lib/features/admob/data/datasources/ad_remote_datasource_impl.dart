import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

class AdRemoteDataSourceImpl implements AdRemoteDataSource {
  final Logger _logger = Logger();
  final Map<String, AdModel> _loadedAds = {};
  bool _isInitialized = false;
  bool _testMode = false;

  @override
  Future<Either<Failure, void>> initializeAdMob() async {
    try {
      if (_isInitialized) {
        return const Right(null);
      }

      await MobileAds.instance.initialize();
      _isInitialized = true;
      _logger.d('AdMob initialized successfully');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to initialize AdMob', error: e);
      return Left(AdMobFailure(message: 'Failed to initialize AdMob: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, AdModel>> loadBannerAd(String adUnitId) async {
    try {
      final adId = 'banner_${DateTime.now().millisecondsSinceEpoch}';
      final adModel = AdModel(
        id: adId,
        adUnitId: adUnitId,
        adType: AdType.banner,
        status: AdStatus.loading,
      );

      _loadedAds[adId] = adModel;
      _logger.d('Loading banner ad: $adId');
      
      // Simulate ad loading success after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Update the ad status to loaded
      _loadedAds[adId] = adModel.copyWith(
        status: AdStatus.loaded,
        loadedAt: DateTime.now(),
      );
      
      return Right(_loadedAds[adId]!);
    } catch (e) {
      _logger.e('Failed to load banner ad', error: e);
      return Left(AdMobFailure(message: 'Failed to load banner ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, AdModel>> loadInterstitialAd(String adUnitId) async {
    try {
      final adId = 'interstitial_${DateTime.now().millisecondsSinceEpoch}';
      final adModel = AdModel(
        id: adId,
        adUnitId: adUnitId,
        adType: AdType.interstitial,
        status: AdStatus.loading,
      );

      _loadedAds[adId] = adModel;
      _logger.d('Loading interstitial ad: $adId');
      
      // Simulate ad loading success after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Update the ad status to loaded
      _loadedAds[adId] = adModel.copyWith(
        status: AdStatus.loaded,
        loadedAt: DateTime.now(),
      );
      
      return Right(_loadedAds[adId]!);
    } catch (e) {
      _logger.e('Failed to load interstitial ad', error: e);
      return Left(AdMobFailure(message: 'Failed to load interstitial ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, AdModel>> loadRewardedAd(String adUnitId) async {
    try {
      final adId = 'rewarded_${DateTime.now().millisecondsSinceEpoch}';
      final adModel = AdModel(
        id: adId,
        adUnitId: adUnitId,
        adType: AdType.rewarded,
        status: AdStatus.loading,
      );

      _loadedAds[adId] = adModel;
      _logger.d('Loading rewarded ad: $adId');
      
      // Simulate ad loading success after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Update the ad status to loaded
      _loadedAds[adId] = adModel.copyWith(
        status: AdStatus.loaded,
        loadedAt: DateTime.now(),
      );
      
      return Right(_loadedAds[adId]!);
    } catch (e) {
      _logger.e('Failed to load rewarded ad', error: e);
      return Left(AdMobFailure(message: 'Failed to load rewarded ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, AdModel>> loadNativeAd(String adUnitId) async {
    try {
      final adId = 'native_${DateTime.now().millisecondsSinceEpoch}';
      final adModel = AdModel(
        id: adId,
        adUnitId: adUnitId,
        adType: AdType.native,
        status: AdStatus.loading,
      );

      _loadedAds[adId] = adModel;
      _logger.d('Loading native ad: $adId');
      
      return Right(adModel);
    } catch (e) {
      _logger.e('Failed to load native ad', error: e);
      return Left(AdMobFailure(message: 'Failed to load native ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, void>> showInterstitialAd(String adId) async {
    try {
      final ad = _loadedAds[adId];
      if (ad == null) {
        return Left(AdMobFailure(message: 'Ad not found: $adId', error: 'Ad not found'));
      }

      if (ad.status != AdStatus.loaded) {
        return Left(AdMobFailure(message: 'Ad not ready to show: $adId', error: 'Ad not ready'));
      }

      _loadedAds[adId] = ad.copyWith(
        status: AdStatus.shown,
        shownAt: DateTime.now(),
      );

      _logger.d('Showing interstitial ad: $adId');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to show interstitial ad', error: e);
      return Left(AdMobFailure(message: 'Failed to show interstitial ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, void>> showRewardedAd(String adId) async {
    try {
      final ad = _loadedAds[adId];
      if (ad == null) {
        return Left(AdMobFailure(message: 'Ad not found: $adId', error: 'Ad not found'));
      }

      if (ad.status != AdStatus.loaded) {
        return Left(AdMobFailure(message: 'Ad not ready to show: $adId', error: 'Ad not ready'));
      }

      _loadedAds[adId] = ad.copyWith(
        status: AdStatus.rewarded,
        shownAt: DateTime.now(),
      );

      _logger.d('Showing rewarded ad: $adId');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to show rewarded ad', error: e);
      return Left(AdMobFailure(message: 'Failed to show rewarded ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, void>> disposeAd(String adId) async {
    try {
      _loadedAds.remove(adId);
      _logger.d('Disposed ad: $adId');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to dispose ad', error: e);
      return Left(AdMobFailure(message: 'Failed to dispose ad: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, AdStatus>> getAdStatus(String adId) async {
    try {
      final ad = _loadedAds[adId];
      if (ad == null) {
        return Left(AdMobFailure(message: 'Ad not found: $adId', error: 'Ad not found'));
      }

      return Right(ad.status);
    } catch (e) {
      _logger.e('Failed to get ad status', error: e);
      return Left(AdMobFailure(message: 'Failed to get ad status: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> isAdReady(String adId) async {
    try {
      final ad = _loadedAds[adId];
      if (ad == null) {
        return Right(false);
      }

      return Right(ad.status == AdStatus.loaded);
    } catch (e) {
      _logger.e('Failed to check if ad is ready', error: e);
      return Left(AdMobFailure(message: 'Failed to check if ad is ready: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, List<AdModel>>> getLoadedAds() async {
    try {
      return Right(_loadedAds.values.toList());
    } catch (e) {
      _logger.e('Failed to get loaded ads', error: e);
      return Left(AdMobFailure(message: 'Failed to get loaded ads: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, void>> clearAllAds() async {
    try {
      _loadedAds.clear();
      _logger.d('Cleared all ads');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to clear all ads', error: e);
      return Left(AdMobFailure(message: 'Failed to clear all ads: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, void>> setTestMode(bool enabled) async {
    try {
      _testMode = enabled;
      _logger.d('Set test mode: $enabled');
      return const Right(null);
    } catch (e) {
      _logger.e('Failed to set test mode', error: e);
      return Left(AdMobFailure(message: 'Failed to set test mode: $e', error: e));
    }
  }

  @override
  Future<Either<Failure, bool>> getTestMode() async {
    try {
      return Right(_testMode);
    } catch (e) {
      _logger.e('Failed to get test mode', error: e);
      return Left(AdMobFailure(message: 'Failed to get test mode: $e', error: e));
    }
  }
}
