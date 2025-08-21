import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class ShowInterstitialAdParams {
  final String adId;

  ShowInterstitialAdParams({required this.adId});
}

class ShowInterstitialAdUsecase implements UseCase<void, ShowInterstitialAdParams> {
  final AdRepository repository;

  ShowInterstitialAdUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(ShowInterstitialAdParams params) async {
    return await repository.showInterstitialAd(params.adId);
  }
}
