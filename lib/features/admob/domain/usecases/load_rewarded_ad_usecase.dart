import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class LoadRewardedAdParams {
  final String adUnitId;

  LoadRewardedAdParams({required this.adUnitId});
}

class LoadRewardedAdUsecase implements UseCase<AdEntity, LoadRewardedAdParams> {
  final AdRepository repository;

  LoadRewardedAdUsecase(this.repository);

  @override
  Future<Either<Failure, AdEntity>> call(LoadRewardedAdParams params) async {
    return await repository.loadRewardedAd(params.adUnitId);
  }
}
