import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class LoadBannerAdParams {
  final String adUnitId;

  LoadBannerAdParams({required this.adUnitId});
}

class LoadBannerAdUsecase implements UseCase<AdEntity, LoadBannerAdParams> {
  final AdRepository repository;

  LoadBannerAdUsecase(this.repository);

  @override
  Future<Either<Failure, AdEntity>> call(LoadBannerAdParams params) async {
    return await repository.loadBannerAd(params.adUnitId);
  }
}
