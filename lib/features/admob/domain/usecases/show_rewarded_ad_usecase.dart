import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class ShowRewardedAdParams {
  final String adId;

  ShowRewardedAdParams({required this.adId});
}

class ShowRewardedAdUsecase implements UseCase<void, ShowRewardedAdParams> {
  final AdRepository repository;

  ShowRewardedAdUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(ShowRewardedAdParams params) async {
    return await repository.showRewardedAd(params.adId);
  }
}
