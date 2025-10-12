import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class AdRepositoryImpl implements AdRepository {
  final AdRemoteDataSource remoteDataSource;

  AdRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> initializeAdMob() async {
    return await remoteDataSource.initializeAdMob();
  }

  @override
  Future<Either<Failure, AdEntity>> loadBannerAd(String adUnitId) async {
    final result = await remoteDataSource.loadBannerAd(adUnitId);
    return result.map((adModel) => adModel.toEntity());
  }

  @override
  Future<Either<Failure, AdEntity>> loadInterstitialAd(String adUnitId) async {
    final result = await remoteDataSource.loadInterstitialAd(adUnitId);
    return result.map((adModel) => adModel.toEntity());
  }

  @override
  Future<Either<Failure, AdEntity>> loadRewardedAd(String adUnitId) async {
    final result = await remoteDataSource.loadRewardedAd(adUnitId);
    return result.map((adModel) => adModel.toEntity());
  }

  @override
  Future<Either<Failure, AdEntity>> loadNativeAd(String adUnitId) async {
    final result = await remoteDataSource.loadNativeAd(adUnitId);
    return result.map((adModel) => adModel.toEntity());
  }

  @override
  Future<Either<Failure, void>> showInterstitialAd(String adId) async {
    return await remoteDataSource.showInterstitialAd(adId);
  }

  @override
  Future<Either<Failure, void>> showRewardedAd(String adId) async {
    return await remoteDataSource.showRewardedAd(adId);
  }

  @override
  Future<Either<Failure, void>> disposeAd(String adId) async {
    return await remoteDataSource.disposeAd(adId);
  }

  @override
  Future<Either<Failure, AdStatus>> getAdStatus(String adId) async {
    return await remoteDataSource.getAdStatus(adId);
  }

  @override
  Future<Either<Failure, bool>> isAdReady(String adId) async {
    return await remoteDataSource.isAdReady(adId);
  }

  @override
  Future<Either<Failure, List<AdEntity>>> getLoadedAds() async {
    final result = await remoteDataSource.getLoadedAds();
    return result.map((adModels) => adModels.map((ad) => ad.toEntity()).toList());
  }

  @override
  Future<Either<Failure, void>> clearAllAds() async {
    return await remoteDataSource.clearAllAds();
  }

  @override
  Future<Either<Failure, void>> setTestMode(bool enabled) async {
    return await remoteDataSource.setTestMode(enabled);
  }

  @override
  Future<Either<Failure, bool>> getTestMode() async {
    return await remoteDataSource.getTestMode();
  }
}
