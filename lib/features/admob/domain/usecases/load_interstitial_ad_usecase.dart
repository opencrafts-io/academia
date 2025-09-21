import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class LoadInterstitialAdParams {
  final String adUnitId;

  LoadInterstitialAdParams({required this.adUnitId});
}

class LoadInterstitialAdUsecase implements UseCase<AdEntity, LoadInterstitialAdParams> {
  final AdRepository repository;

  LoadInterstitialAdUsecase(this.repository);

  @override
  Future<Either<Failure, AdEntity>> call(LoadInterstitialAdParams params) async {
    return await repository.loadInterstitialAd(params.adUnitId);
  }
}
